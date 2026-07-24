class_name MenuLayer
extends CanvasLayer


func hide_children() -> void:
	for child: Control in get_children():
		child.hide()
