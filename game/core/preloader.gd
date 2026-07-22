extends Node


@export var scenes_to_load: Array[PackedScene] = []

var player_identified: bool = false
var all_objects_preloaded: bool = false


func _init() -> void:
	EventBus.setup_events.player_identified.connect(on_player_identified)

func _ready() -> void:
	for scene: PackedScene in scenes_to_load:
		var new_scene := scene.instantiate()
		add_child(new_scene)
		if "global_position" in new_scene:
			new_scene.global_position = get_viewport().get_camera_2d().get_screen_center_position()
		for i in range(0,2):
			await get_tree().process_frame
		new_scene.queue_free()
	for i in range(0,2):
		await get_tree().process_frame

	all_objects_preloaded = true
	if player_identified:
		finish_preloading()

func on_player_identified() -> void:
	player_identified = true
	if all_objects_preloaded:
		finish_preloading()

func finish_preloading() -> void:
	EventBus.setup_events.preloading_completed.emit()
	queue_free()
