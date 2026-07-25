class_name TaskManager
extends Node


@export var task_ui_prefab: PackedScene

@onready var task_parent: VBoxContainer = %TaskParent

var tasks: Array[TaskTemplate]
var task_to_task_ui: Dictionary[TaskTemplate, TaskUI] = {}
var tasks_completed: int


func initialize(tasks_in: Array[TaskTemplate]) -> void:
	tasks = tasks_in
	for task: TaskTemplate in tasks:
		var task_ui: TaskUI = task_ui_prefab.instantiate()
		task_parent.add_child(task_ui)
		task_to_task_ui[task] = task_ui
		task_ui.initialize(task.text)
	EventBus.game_events.task_completed.connect(on_task_completed)

func on_task_completed(tool: ToolTemplate, reagent: Reagent) -> void:
	for task: TaskTemplate in task_to_task_ui.keys():
		if task.tool == tool && task.reagent == reagent:
			task_to_task_ui[task].complete()
			task_to_task_ui.erase(task)
			tasks_completed += 1
			if tasks_completed >= tasks.size():
				EventBus.game_events.level_completed.emit()
			break
