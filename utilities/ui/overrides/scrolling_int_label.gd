class_name ScrollingIntLabel
extends Label


@export var duration_seconds: float = 1.0
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType

var tween: Tween


func set_number(number: int) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(transition_type)
	tween.set_ease(ease_type)
	tween.tween_method(func(i: int) -> void: text = str(i), int(text), number, duration_seconds)
