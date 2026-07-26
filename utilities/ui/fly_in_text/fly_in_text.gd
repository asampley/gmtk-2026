class_name FlyInText
extends Control


@export var duration: float

@onready var label: Label = %Label

var movement_vector: Vector2
var impact: float

signal vars_set()
signal animation_triggered()


func initialize(text_in: String, movement_vector_in: Vector2, impact_in: float) -> void:
	label.text = text_in
	scale = Vector2(0,0)
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 1)
	
	await tween.finished
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, .5)
	
	await tween.finished
	queue_free()
