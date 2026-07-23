class_name Tool
extends TextureRect

@export var tool_template: ToolTemplate


func _gui_input(event: InputEvent) -> void:
	if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
		print("click")
