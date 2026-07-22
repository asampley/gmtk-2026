class_name FlyInText
extends Control


@export var duration: float

@onready var label: Label = %Label
@onready var animation_container: AnimationContainer = %AnimationContainer

var movement_vector: Vector2
var impact: float

signal vars_set()
signal animation_triggered()


func initialize(text_in: String, movement_vector_in: Vector2, impact_in: float) -> void:
	label.text = text_in
	movement_vector = movement_vector_in
	impact = impact_in
	vars_set.emit()
	animation_triggered.emit(true)
	
	await get_tree().create_timer(duration).timeout
	queue_free()

func add_animation(animation: UIAnimation) -> void:
	animation_container.animations.append(animation)
