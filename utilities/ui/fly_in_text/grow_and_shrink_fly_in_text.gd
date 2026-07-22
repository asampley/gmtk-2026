class_name GrowAndShrinkFlyInText
extends Label


@export var scale_seconds: float = 0.2
@export var duration_seconds: float = 3
@export var scale_easing: Tween.EaseType
@export var scale_transition: Tween.TransitionType
@export var scale_from_center := true

var default_scale: Vector2


func initialize(text_in: String, movement_vector: Vector2) -> void:
	EventBus.game_events.game_ended.connect(on_game_ended)
	text = text_in
	default_scale = scale
	scale = Vector2(0,0)
	if scale_from_center:
		pivot_offset = size / 2
	set_scale_tween(default_scale)
	
	await get_tree().create_timer(duration_seconds).timeout
	set_scale_tween(Vector2(0,0))

func on_game_ended() -> void:
	queue_free()

func set_scale_tween(scale: Vector2) -> void:
	var tween := self.create_tween()
	tween.set_ease(scale_easing)
	tween.set_trans(scale_transition)
	tween.tween_property(self, "scale", scale, scale_seconds)
