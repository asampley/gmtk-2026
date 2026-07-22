class_name ModulateUIAnimation
extends UIAnimation


@export var color: Color = Color.TRANSPARENT


func _init() -> void:
	property = "modulate"

func _activate_animation(control: Control) -> void:
	property = "modulate"
	if reversed:
		control.modulate = color
		var color_to_set: Color = default_properties["modulate"]
		animate(control, color_to_set)
	else:
		animate(control, color)

func _deactivate_animation(control: Control) -> void:
	property = "modulate"
	if reversed:
		animate(control, color)
	else:
		var color_to_set: Color = default_properties["modulate"]
		animate(control, color_to_set)
