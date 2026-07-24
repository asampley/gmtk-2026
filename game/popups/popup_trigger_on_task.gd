class_name PopupTriggerOnTask
extends Node


@export var index: int
@export var task_index: int


func _ready() -> void:
	EventBus.game_events.task_completed.connect(on_task_completed)

func on_task_completed(task_index_in: int) -> void:
	if task_index == task_index_in:
		EventBus.game_events.popup_requested.emit(index)
