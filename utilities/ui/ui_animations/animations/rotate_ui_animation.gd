class_name RotateUIAnimation
extends UIAnimation


@export var rotation_deg: float


func _init() -> void:
	property = "rotation"

func _activate_animation(control: Control) -> void:
	if reversed:
		control.rotation = deg_to_rad(rotation_deg)
		var rotation_to_set: float = default_properties["rotation"]
		animate(control, rotation_to_set)
	else:
		animate(control, deg_to_rad(rotation_deg))

func _deactivate_animation(control: Control) -> void:
	if reversed:
		animate(control, deg_to_rad(rotation_deg))
	else:
		var rotation_to_set: float = default_properties["rotation"]
		animate(control, rotation_to_set)
