class_name PopupTriggerLevelStart
extends Node


@export var index: int


func _ready() -> void:
	EventBus.game_events.popup_requested.emit(index)
