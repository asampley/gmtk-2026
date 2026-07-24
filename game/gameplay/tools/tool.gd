class_name Tool
extends TextureRect


@export var tool_template: ToolTemplate
@export var held_reagents_ui: HeldReagentsUI
@export var reagent_readers: Array[ReagentReader]
@export var reagent_whitelist: Array[Reagent]
@export var is_locked: bool = false
@export var will_decay: bool = true

var initialized: bool = false
var selection_manager: SelectionManager
var reagent_generators: Array[ReagentGeneration]

var recipes: Array[Resource]
var reagent_to_reaction_progress: Dictionary[Reagent, ReactionProgress] = {}
var removable_reagent: Reagent:
	get:
		if reagent_to_reaction_progress.size() != 1 || is_locked:
			return null
		else:
			return reagent_to_reaction_progress.keys().front()

signal updated_reagents(reagents_out: Dictionary[Reagent, ReactionProgress])

func initialize(selection_manager_in: SelectionManager) -> void:
	selection_manager = selection_manager_in
	if tool_template.reagent_generation_templates:
		print_debug(tool_template.reagent_generation_templates)
		for reagent_generation_template: ReagentGenerationTemplate in tool_template.reagent_generation_templates:
			var reagent_generation := ReagentGeneration.new()
			reagent_generation.initialize(reagent_generation_template)
			reagent_generators.append(reagent_generation)
	held_reagents_ui.initialize(self)
	recipes = ResourceDataHandler.resource_dict["recipes"]
	recipes = recipes.filter(func(recipe: Recipe) -> bool:
		return recipe.tool_template == tool_template
	)
	setup_whitelist()
	if reagent_readers.size() > 0:
		for reagent_reader: ReagentReader in reagent_readers:
			reagent_reader.initialize(self)
	initialized = true

func _gui_input(event: InputEvent) -> void:
	if is_selection_event(event) :
		selection_manager.select(self)
		accept_event()

func _process(delta: float) -> void:
	if !initialized:
		return
	for reagent_generator: ReagentGeneration in reagent_generators:
		reagent_generator.update(delta)
		if reagent_generator.max_reagents >= 1:
			add_reagent(reagent_generator.reagent)
	if will_decay:
		_progress_reaction(delta)

func setup_whitelist() -> void:
	for generator: ReagentGeneration in reagent_generators:
		add_reagent_to_whitelist(generator.reagent)
	for recipe: Recipe in recipes:
		for reagent: Reagent in recipe.reagents:
			add_reagent_to_whitelist(reagent)
		for reagent: Reagent in recipe.products:
			add_reagent_to_whitelist(reagent)
	for reagent: Reagent in ResourceDataHandler.resource_dict["reagents"]:
		for decay_template: DecayTemplate in reagent.decay_templates:
			if decay_template.tool == tool_template:
				add_reagent_to_whitelist(reagent)
				for catalyst: Catalyst in decay_template.catalysts:
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
	if reagent_to_reaction_progress.has(reagent):
		return false
	if !reagent_whitelist.has(reagent):
		return false
	return true

func add_reagent(reagent: Reagent) -> void:
	add_reagents([reagent])

func remove_reagent(reagent: Reagent) -> void:
	remove_reagents([reagent])

func add_reagents(new_reagents: Array[Reagent]) -> void:
	var array_size := reagent_to_reaction_progress.size();
	for reagent: Reagent in new_reagents:
		if !reagent_to_reaction_progress.has(reagent):
			reagent_to_reaction_progress[reagent] = ReactionProgress.new()
			reagent_to_reaction_progress[reagent].initialize(reagent.get_decay_template(tool_template))
	if reagent_to_reaction_progress.size() != array_size:
		_calculate_recipes()
	updated_reagents.emit(reagent_to_reaction_progress)

func remove_reagents(old_reagents: Array[Reagent]) -> void:
	var array_size := reagent_to_reaction_progress.size()
	for reagent in old_reagents:
		if reagent_to_reaction_progress.has(reagent):
			reagent_to_reaction_progress.erase(reagent)
	if array_size != reagent_to_reaction_progress.size():
		_calculate_recipes()
	updated_reagents.emit(reagent_to_reaction_progress)

# Check if all required ingredients exist. 
# Then immediately make the product and remove reagents if so.
func _calculate_recipes() -> void:
	#print_debug("Recalculating recipes for ", self)
	for recipe: Recipe in recipes:
		if has_all_reagents_for_recipe(recipe.reagents):
			for reagent: Reagent in recipe.reagents:
				reagent_to_reaction_progress.erase(reagent)
			add_reagents(recipe.products)

func has_all_reagents_for_recipe(reagents: Array[Reagent]) -> bool:
	for reagent: Reagent in reagents:
		if !reagent_to_reaction_progress.keys().has(reagent):
			return false
	return true

# Advances reactions with a delta time
func _progress_reaction(delta: float) -> void:
	var reagents: Array[Reagent] = reagent_to_reaction_progress.keys()
	for reagent: Reagent in reagents:
		if reagent_to_reaction_progress[reagent].reagent_state != ReactionProgress.ReagentState.STABLE:
			if reagent_to_reaction_progress[reagent].progress(delta, reagent_to_reaction_progress.keys()):
				reagent_to_reaction_progress.erase(reagent)
				if reagent.get_decay_template(tool_template).product:
					add_reagent(reagent.get_decay_template(tool_template).product)
	updated_reagents.emit(reagent_to_reaction_progress)

func _get_drag_data(_at_position: Vector2) -> Variant:
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is Tool:
		var tool := data as Tool
		var reagent := tool.removable_reagent
		if reagent && can_take_reagent(reagent):
			return true
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var tool := data as Tool
	add_reagent(tool.removable_reagent)
	tool.remove_reagent(tool.removable_reagent)
