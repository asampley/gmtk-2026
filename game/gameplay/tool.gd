class_name Tool
extends TextureRect

@export var tool_template: ToolTemplate

var selection_manager: SelectionManager
var reagents: Array[Reagent]
var removable_reagent: Reagent:
	get:
		if reagents.size() != 1: 
			return null
		else:
			return reagents[0]


func initialize(selection_manager_in: SelectionManager) -> void:
	selection_manager = selection_manager_in

func _gui_input(event: InputEvent) -> void:
	if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
		selection_manager.select(self)
