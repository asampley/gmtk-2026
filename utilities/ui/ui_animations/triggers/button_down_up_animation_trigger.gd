class_name ButtonDownUpAnimationTrigger
extends AnimationTrigger


func _ready() -> void:
	parent = get_parent()
	if !(parent.has_signal("button_down")):
		printerr("ButtonDownUpAnimationTrigger not assigned to a button.")
		return
	parent.button_down.connect(_trigger.bind(true))
	parent.button_up.connect(_trigger.bind(false))
