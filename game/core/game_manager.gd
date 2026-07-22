extends Node


signal game_manager_loaded()


func _ready() -> void:
	game_manager_loaded.emit()
