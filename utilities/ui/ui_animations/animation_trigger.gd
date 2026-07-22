class_name AnimationTrigger
extends Node


@export var one_way: bool
@export_range(0.0, 600) var activate_delay_seconds: float
@export_range(0.0, 600) var deactivate_delay_seconds: float

var parent: Node

signal animation_triggered(activate: bool)


func _trigger(activate: bool) -> void:
	if activate && activate_delay_seconds > 0:
		await get_tree().create_timer(activate_delay_seconds).timeout
	elif !activate && deactivate_delay_seconds > 0:
		await get_tree().create_timer(deactivate_delay_seconds).timeout
	if one_way && !activate:
		return
	animation_triggered.emit(activate)
