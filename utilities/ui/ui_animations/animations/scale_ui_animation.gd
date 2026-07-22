class_name ScaleUIAnimation
extends UIAnimation


@export var scale := Vector2(1,1)


func _init() -> void:
	property = "scale"
	
func _activate_animation(control: Control) -> void:
	if reversed:
		control.scale = scale
		var scale_to_set: Vector2 = default_properties["scale"]
		animate(control, scale_to_set)
	else:
		animate(control, scale)

func _deactivate_animation(control: Control) -> void:
	if reversed:
		animate(control, scale)
	else:
		var scale_to_set: Vector2 = default_properties["scale"]
		animate(control, scale_to_set)
		print(control.get_instance_id())
		print(scale_to_set)
		print(control.scale)
