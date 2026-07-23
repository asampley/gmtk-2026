class_name Tool
extends TextureRect

@export var tool_template: ToolTemplate
@export var held_reagents_ui: HeldReagentsUI

var initialized: bool = false
var selection_manager: SelectionManager
var reagent_generators: Array[ReagentGeneration]
var reagents: Array[Reagent]
var removable_reagent: Reagent:
	get:
		if reagents.size() != 1: 
			return null
		else:
			return reagents[0]

signal updated_reagents(reagents_out: Array[Reagent])

func initialize(selection_manager_in: SelectionManager) -> void:
	selection_manager = selection_manager_in
	if tool_template.reagent_generation_templates:
		print_debug(tool_template.reagent_generation_templates)
		for reagent_generation_template: ReagentGenerationTemplate in tool_template.reagent_generation_templates:
			var reagent_generation := ReagentGeneration.new()
			reagent_generation.initialize(reagent_generation_template)
			reagent_generators.append(reagent_generation)
	held_reagents_ui.initialize(self)
	initialized = true

func _gui_input(event: InputEvent) -> void:
	if is_selection_event(event):
		selection_manager.select(self)

func _process(delta: float) -> void:
	if ! initialized:
		return
	for reagent_generator: ReagentGeneration in reagent_generators:
		reagent_generator.update(delta)
		if reagent_generator.max_reagents >= 1:
			add_reagent(reagent_generator.reagent)

func is_selection_event(event: InputEvent) -> bool:
	if !(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		return false
	if !(event.is_action_pressed("left_mouse") || event.is_action_released("left_mouse")):
		return false
	return true

func can_take_reagent(reagent: Reagent) -> bool:
	if reagents.has(reagent):
		return false
	return true

func add_reagent(reagent: Reagent) -> void:
	if !reagents.has(reagent):
		reagents.append(reagent)
		updated_reagents.emit(reagents)

func remove_reagent(reagent: Reagent) -> void:
	if reagents.has(reagent):
		reagents.erase(reagent)
		updated_reagents.emit(reagents)
