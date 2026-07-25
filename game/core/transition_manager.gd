class_name TransitionManager
extends CanvasLayer


@export var texture: ColorRect
@export var scene_transition_min_s: float = 1.0

var tween: Tween

signal fade_completed()


func begin_transition() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(set_shader_value, 1.0, 0, scene_transition_min_s)
	texture.mouse_filter = Control.MOUSE_FILTER_STOP
	await tween.finished
	fade_completed.emit()

func set_shader_value(value: float) -> void:
	texture.material.set_shader_parameter("progress", value)

func end_transition() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(set_shader_value, -.10, 1.0, scene_transition_min_s)
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
