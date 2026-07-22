class_name VisibleAnimationTrigger
extends AnimationTrigger


func _ready() -> void:
	parent = get_parent()
	if !(parent.has_signal("visibility_changed")):
		printerr("VisibleAnimationTrigger not assigned to node that can be made visible.")
		return
	parent.visibility_changed.connect(_trigger.bind(!parent.visible))
