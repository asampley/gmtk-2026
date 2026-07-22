class_name ButtonPressedAnimationTrigger
extends AnimationTrigger



func _ready() -> void:
	parent = get_parent()
	if !(parent.has_signal("pressed")):
		printerr("ButtonPressedAnimationTrigger not assigned to a button.")
		return
	parent.pressed.connect(_trigger.bind(true))
	parent.pressed.connect(deactivate)

func deactivate() -> void:
	await get_tree().create_timer(deactivate_delay_seconds).timeout
	
	_trigger(false)
