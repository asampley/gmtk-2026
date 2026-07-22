class_name SignalAnimationTrigger
extends AnimationTrigger


func _ready() -> void:
	parent = get_parent()
	if !(parent.has_signal("animation_triggered")):
		printerr("SignalAnimationTrigger not assigned to node that has an animation_triggered signal.")
		return
	parent.animation_triggered.connect(_trigger)
