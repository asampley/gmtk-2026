class_name MoveDirectionalUIAnimation
extends UIAnimation


@export var direction: Vector2


func _init() -> void:
	property = "position"

func _activate_animation(control: Control) -> void:
	if reversed:
		var start_pos: Vector2 = default_properties["position"] + direction
		control.position = start_pos
		var pos_to_set: Vector2 = default_properties["position"]
		animate(control, pos_to_set)
	else:
		var pos_to_set: Vector2 = default_properties["position"] + direction
		animate(control, pos_to_set)

func _deactivate_animation(control: Control) -> void:
	if reversed:
		var pos_to_set: Vector2 = default_properties["position"] + direction
		animate(control, pos_to_set)
	else:
		var pos_to_set: Vector2 = default_properties["position"]
		animate(control, pos_to_set)
