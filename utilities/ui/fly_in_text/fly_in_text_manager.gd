class_name FlyInTextManager
extends Control

## Set fly_in_text_manager.tscn as the child of a Canvas node.
## Must create a signal in the EventBus and connect it to the desired text
##
## Get the spawn position using 
## .get_global_transform_with_canvas().get_origin()
## on the object calling the signal
##



@export var text_prefabs: Array[PackedScene] = []
var instance: FlyInTextManager


func _ready() -> void:
	EventBus.ui_events.fly_in_text_requested.connect(on_fly_in_text_requested)

func on_fly_in_text_requested(text: String, prefab_int: int, position_in: Vector2,\
		impact: float, direction: Vector2) -> void:
	if text_prefabs.size() <= prefab_int :
		printerr("Fly in text calling missing array")
		return
	var fly_in_text: Control = text_prefabs[prefab_int].instantiate()
	self.add_child(fly_in_text)
	fly_in_text.position = position_in
	fly_in_text.initialize(text, direction, impact)
