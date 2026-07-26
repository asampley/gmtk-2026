class_name AnimationControl
extends Container


@export var trigger: AnimationTrigger
@export var is_parallel := true
@export var from_center := true
@export var animations: Array[UIAnimation] = []

var default_properties: Dictionary = {}


func _ready() -> void:
	item_rect_changed.connect(_update_pivot_offset)
	_update_pivot_offset()
	default_properties["position"] = position
	default_properties["scale"] = scale
	default_properties["rotation"] = rotation
	default_properties["modulate"] = modulate
	if !trigger:
		printerr("Trigger missing from animation control.")
		return
	trigger.animation_triggered.connect(on_trigger)

func on_trigger(activate: bool) -> void:
	if activate:
		on_activate()
	else:
		on_deactivate()

func on_activate() -> void:
	if is_parallel:
		for animation: UIAnimation in animations:
			animation._activate_animation(self)
	else:
		for animation: UIAnimation in animations:
			animation._activate_animation(self)
			await animation.completed

func on_deactivate() -> void:
	if is_parallel:
		for animation: UIAnimation in animations:
			animation._deactivate_animation(self)
	else:
		for animation: UIAnimation in animations:
			animation._deactivate_animation(self)
			await animation.completed

func clear_all_animation_tweens() -> void:
	for animation: UIAnimation in animations:
		animation.clear_tweens()

func _update_pivot_offset() -> void:
	if from_center:
		pivot_offset = size / 2
