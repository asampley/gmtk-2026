class_name Tool
extends TextureRect

@export var tool_template: ToolTemplate

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


func initialize(selection_manager_in: SelectionManager) -> void:
	selection_manager = selection_manager_in
	if tool_template.reagent_generation_templates:
		print_debug(tool_template.reagent_generation_templates)
		for reagent_generation_template: ReagentGenerationTemplate in tool_template.reagent_generation_templates:
			var reagent_generation := ReagentGeneration.new()
			reagent_generation.initialize(reagent_generation_template)
			reagent_generators.append(reagent_generation)
	initialized = true

func _gui_input(event: InputEvent) -> void:
	if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
		selection_manager.select(self)

func _process(delta: float) -> void:
	if ! initialized:
		return
	for reagent_generator: ReagentGeneration in reagent_generators:
		reagent_generator.update(delta)
		if reagent_generator.max_reagents >= 1:
			add_reagent(reagent_generator.reagent)


func add_reagent(reagent: Reagent) -> void:
	if !reagents.has(reagent):
		reagents.append(reagent)
