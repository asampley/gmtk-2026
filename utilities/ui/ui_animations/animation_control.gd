class_name AnimationControl
extends Container


@export var trigger: AnimationTrigger
@export var from_center := true
@export var ui_animation_data: UIAnimationData
var animatable: Animatable = Animatable.new()


func _ready() -> void:
	item_rect_changed.connect(_update_pivot_offset)
	_update_pivot_offset()
	if !trigger:
		printerr("Trigger missing from animation control.")
		return
	animatable.initialize(self, ui_animation_data)
	trigger.animation_triggered.connect(animatable.on_trigger)

func _update_pivot_offset() -> void:
	if from_center:
		pivot_offset = size / 2
