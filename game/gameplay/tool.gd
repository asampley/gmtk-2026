class_name Tool
extends TextureRect

@export var tool_template: ToolTemplate


func _gui_input(event: InputEvent) -> void:
	if event == InputEventMouseButton:
		print("click")
