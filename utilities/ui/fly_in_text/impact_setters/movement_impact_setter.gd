class_name DirectionImpactSetter
extends Node


@export var movement_mult: float
@export var uses_impact: bool
@export var animation: MoveDirectionalUIAnimation


var parent: FlyInText


func _ready() -> void:
	parent = get_parent()
	if !(parent is FlyInText):
		print("Impact setter assigned to non-FlyInText")
		return
	parent.vars_set.connect(on_vars_set) 

func on_vars_set() -> void:
	animation.direction = parent.movement_vector * movement_mult
	var direction_distance := parent.movement_vector * movement_mult
	if uses_impact:
		direction_distance *= parent.impact
	animation.direction = direction_distance
	parent.add_animation(animation)
