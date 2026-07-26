class_name Tool
extends TextureRect


@export var tool_template: ToolTemplate
@export var held_reagents_ui: HeldReagentsUI
@export var task_reagent_reader: TaskReagentReader
@export var reagent_whitelist: Array[Reagent]
@export var is_locked: bool = false
@export var will_decay: bool = true
@export var changes_music: bool
@export var music_bus: String

var initialized: bool = false
var selection_manager: SelectionManager:
	set(value):
			print(value)
			selection_manager = value
var reagent_generators: Array[ReagentGeneration]
var reagents: Array[Reagent]
var removable_reagent: Reagent:
	get:
		if reagents.size() != 1:
			return null
		else:
			return reagents[0]

var _flag_updated_reagents: bool = false
var _flag_updated_reactions: bool = false

var reaction_progress: ReactionProgress = ReactionProgress.new()

signal updated_reagents(reagents_out: Array[Reagent])
signal updated_reactions(reaction_progress: ReactionProgress)


func initialize(selection_manager_in: SelectionManager) -> void:
	if !selection_manager_in:
		hide()
		return
	selection_manager = selection_manager_in
	if tool_template.reagent_generation_templates:
		print_debug(tool_template.reagent_generation_templates)
		for reagent_generation_template: ReagentGenerationTemplate in tool_template.reagent_generation_templates:
			var reagent_generation := ReagentGeneration.new()
			reagent_generation.initialize(reagent_generation_template)
			reagent_generators.append(reagent_generation)
	held_reagents_ui.initialize(self)
	if task_reagent_reader:
		task_reagent_reader.initialize(self)
	setup_whitelist()
	tooltip_text = tool_template.name
	initialized = true

func _gui_input(event: InputEvent) -> void:
	if is_selection_event(event):
		selection_manager.select(self)
		accept_event()

func on_pulse(_pulse: int) -> void:
	if !initialized:
		return
	for reagent_generator: ReagentGeneration in reagent_generators:
		reagent_generator.update(1)
		if reagent_generator.max_reagents >= 1:
			add_reagent(reagent_generator.reagent)

func on_tick(pulse: int, tick: int, per_pulse: int) -> void:
	_progress_reaction(pulse, tick, per_pulse)

	#if _flag_updated_reagents:
		#updated_reagents.emit(reagents)
	#if _flag_updated_reactions:
		#updated_reactions.emit(reaction_progress)

func setup_whitelist() -> void:
	var recipes := ServiceLocator.game_manager.recipes
	recipes = recipes.filter(func(recipe: Recipe) -> bool:
		return recipe.tool_template == tool_template
	)
	for generator: ReagentGeneration in reagent_generators:
		add_reagent_to_whitelist(generator.reagent)
	for recipe: Recipe in recipes:
		for reagent: Reagent in recipe.reagents:
			add_reagent_to_whitelist(reagent)
		for reagent: Reagent in recipe.products:
			add_reagent_to_whitelist(reagent)
		for catalyst: Catalyst in recipe.catalysts:
			add_reagent_to_whitelist(catalyst.reagent)

func add_reagent_to_whitelist(reagent_to_whitelist: Reagent) -> void:
	if !reagent_whitelist.has(reagent_to_whitelist):
		reagent_whitelist.append(reagent_to_whitelist)

func is_selection_event(event: InputEvent) -> bool:
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return false
	if !(event.is_action_released("left_mouse")):
		return false
	return true

func can_take_reagent(reagent: Reagent) -> bool:
	if reagents.has(reagent) || !reagent_whitelist.has(reagent):
		return false
	return true

func add_reagent(reagent: Reagent) -> void:
	add_reagents([reagent])

func remove_reagent(reagent: Reagent) -> void:
	remove_reagents([reagent])

func add_reagents(new_reagents: Array[Reagent]) -> void:
	var changed := false
	for reagent in new_reagents:
		if !reagents.has(reagent):
			reagents.append(reagent)
			changed = true
	if changed:
		update_changes()

func remove_reagents(old_reagents: Array[Reagent]) -> void:
	var changed := false
	for reagent in old_reagents:
		if reagents.has(reagent):
			reagents.erase(reagent)
			changed = true
	if changed:
		update_changes()

func update_changes() -> void:
	_calculate_recipes()
	_flag_updated_reagents = true
	updated_reagents.emit(reagents)
	updated_reactions.emit(reaction_progress)
	if changes_music:
		if reagents.size() > 0:
			EventBus.audio_events.music_bus_audible.emit(music_bus)
		else:
			EventBus.audio_events.music_bus_muted.emit(music_bus)

# Calculate recipes that should be in progress
# Ties are broken by shortest duration
func _calculate_recipes() -> void:
	var recipes := ServiceLocator.game_manager.recipes
	recipes = recipes.filter(func(recipe: Recipe) -> bool:
		return recipe.tool_template == tool_template
	)

	# Used to determine if undesirable reactions should continue. Desirable reactions take precedence.
	var reagent_has_desirable_recipe: Dictionary[Reagent, bool]

	for recipe in recipes:
		if recipe.desirable && Globals.has_all(reagents, recipe.reagents):
			for reagent in recipe.reagents:
				reagent_has_desirable_recipe[reagent] = true

	for recipe: Recipe in recipes:
		var recipe_progress := reaction_progress.recipe_progress
		if !Globals.has_all(reagents, recipe.reagents):
			if recipe_progress.has(recipe):
				reaction_progress.recipe_progress.erase(recipe)
		else:
			var time_multiplier := 1.0

			for catalyst in recipe.catalysts:
				if reagents.has(catalyst.reagent):
					print_debug("catalyst present for " + recipe.name + ": " + catalyst.reagent.name)
					time_multiplier *= catalyst.time_multiplier
					print_debug("time_multiplier now ", time_multiplier)

			if !recipe_progress.has(recipe):
				reaction_progress.recipe_progress[recipe] = ReactionProgress.RecipeProgress.new()
				recipe_progress[recipe].remaining_time = recipe.time
				EventBus.ui_events.fly_in_text_requested.emit(recipe.name, 0, global_position + Vector2(size.x / 2, size.y / 2), 0, Vector2(0,0))
			recipe_progress[recipe].time_multiplier = time_multiplier

			# disable undesirable recipes if there is a recipe desirable
			var paused := !recipe.desirable && Globals.has_any(recipe.reagents, reagent_has_desirable_recipe.keys())

			recipe_progress[recipe].paused = paused

	_flag_updated_reactions = true

# Advances reactions with a delta time
func _progress_reaction(pulse: int, tick: int, per_pulse: int) -> void:
	var recipes_advancing: Array[Recipe] = reaction_progress.recipe_progress.keys()\
		.filter(func(recipe: Recipe) -> bool: return !reaction_progress.recipe_progress[recipe].paused)

	var reagents_to_remove: Array[Reagent] = []
	var reagents_to_add: Array[Reagent] = []

	for recipe in recipes_advancing:
		var rp := reaction_progress.recipe_progress[recipe]
		if posmod(pulse * per_pulse + tick, ceili(rp.time_multiplier * per_pulse)) == 0:
			rp.remaining_time -= 1
		if rp.remaining_time <= 0:
			reagents_to_add.append_array(recipe.products)
			reagents_to_remove.append_array(recipe.reagents)

	if reagents_to_remove.size() > 0:
		remove_reagents(reagents_to_remove)
	if reagents_to_add.size() > 0:
		# reset recipes by removing first
		remove_reagents(reagents_to_add)
		add_reagents(reagents_to_add)

func _get_drag_data(at_position: Vector2) -> Variant:
	var preview_texture := TextureRect.new()
	preview_texture.texture = removable_reagent.icon
	print(preview_texture.position)
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.set_size(Vector2(64,64))
	preview_texture.position -= Vector2(preview_texture.size.x / 2 - 15, 30)
	print(preview_texture.position)
	var preview := Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Tool:
		var tool := data as Tool
		var reagent := tool.removable_reagent
		if reagent && can_take_reagent(reagent):
			return true
		if tool != self:
			EventBus.audio_events.sfx_request.emit(EventBus.SFX.NEGATIVE)
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var tool := data as Tool
	add_reagent(tool.removable_reagent)
	tool.remove_reagent(tool.removable_reagent)
	EventBus.audio_events.sfx_request.emit(EventBus.SFX.AFFIRMATIVE)
