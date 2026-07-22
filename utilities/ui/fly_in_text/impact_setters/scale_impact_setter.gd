class_name ScaleImpactSetter
extends Node


@export var animation: ScaleUIAnimation
@export var scale_mult := Vector2(1,1)
@export var scale_min := Vector2(0.1,0.1)
@export var scale_max := Vector2(10,10)

var parent: FlyInText


func _ready() -> void:
	parent = get_parent()
	if !(parent is FlyInText):
		print("Impact setter assigned to non-FlyInText")
		return
	parent.vars_set.connect(on_vars_set) 

func on_vars_set() -> void:
	var scale: Vector2 = scale_mult * parent.impact
	scale.x = clampf(scale.x, scale_min.x, scale_max.x)
	scale.y = clampf(scale.y, scale_min.y, scale_max.y)
	animation.scale = scale
	parent.add_animation(animation)
