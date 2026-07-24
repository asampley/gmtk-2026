class_name TaskManager
extends Node


@export var tasks: Array[TaskTemplate]
@export var task_ui_prefab: PackedScene

@onready var task_parent: VBoxContainer = %TaskParent

var index_to_task_ui: Dictionary[int, TaskUI] = {}
var tasks_completed: int


func _ready() -> void:
	for task: TaskTemplate in tasks:
		var task_ui: TaskUI = task_ui_prefab.instantiate()
		task_parent.add_child(task_ui)
		index_to_task_ui[task.index] = task_ui
		task_ui.initialize(task.text)
	EventBus.game_events.task_completed.connect(on_task_completed)

func on_task_completed(index: int) -> void:
	if !index_to_task_ui.has(index):
		return
	index_to_task_ui[index].complete()
	tasks_completed += 1
	if tasks_completed >= tasks.size():
		print_debug("Winner")
