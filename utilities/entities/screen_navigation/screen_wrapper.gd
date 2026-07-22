class_name ScreenWrapper
extends Node2D

## Will teleport assigned node to other side of screen if it goes out of camera range.


var parent: Node2D
var x_limits: Vector2
var y_limits: Vector2


func initialize(parent_in: Node2D) -> void:
	var screen_limits := get_viewport_rect().size / 2
	var screen_pos: Vector2 = get_viewport().get_camera_2d().global_position
	x_limits = Vector2(screen_pos.x - screen_limits.x, screen_pos.x + screen_limits.x)
	y_limits = Vector2(screen_pos.y - screen_limits.y, screen_pos.y + screen_limits.y)
	parent = parent_in

func _physics_process(delta: float) -> void:
	if !parent:
		return
	wrap_position()

func wrap_position() -> void:
	var pos: Vector2 = get_parent().position
	parent.position.x = wrapf(pos.x, x_limits.x, x_limits.y)
	parent.position.y = wrapf(pos.y, y_limits.x, y_limits.y)
