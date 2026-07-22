class_name UIAnimation
extends Resource


@export var reversed: bool
@export var duration: float
@export var delay: float
@export var easing: Tween.EaseType
@export var transition: Tween.TransitionType

var property: String
var default_properties: Dictionary = {}
var tween: Tween

signal completed()


func _activate_animation(_control: Control) -> void:
	pass

func _deactivate_animation(_control: Control) -> void:
	pass

func clear_tweens() -> void:
	if tween:
		tween.kill()

func setup_tween(control: Control) -> void:
	tween = control.create_tween()	
	tween.set_ease(easing)
	tween.set_trans(transition)

func animate(control: Control, value: Variant) -> void:
	clear_tweens()
	setup_tween(control)
	tween.tween_property(control, property, value, duration).set_delay(delay)

	await tween.finished
	completed.emit()
	clear_tweens()
	if reversed:
		control.set(property, control.default_properties[property])
