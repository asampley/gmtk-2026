class_name ControlManager
extends Node


@warning_ignore_start("unused_signal")

signal movement_set(is_moving: bool, dest: Vector2)
signal rotation_set(rotation: float)
signal action_pressed(index: int, use_requested: bool)
signal shield_used(active: bool, timed: bool)

@warning_ignore_restore("unused_signal")

func _initialize() -> void:
	pass
