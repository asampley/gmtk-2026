class_name MouseOverAnimationTrigger
extends AnimationTrigger


func _ready() -> void:
	parent = get_parent()
	if !(parent is Control):
		printerr("MouseOverAnimation not assigned to a control.")
		return
	parent.mouse_entered.connect(_trigger.bind(true))
	parent.mouse_exited.connect(_trigger.bind(false))
