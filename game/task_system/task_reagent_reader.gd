class_name TaskReagentReader
extends Node


var tool_template: ToolTemplate


func initialize(tool_in: Tool) -> void:
	tool_template = tool_in.tool_template
	tool_in.updated_reagents.connect(_on_updated_reagents)

func _on_updated_reagents(reagents: Array[Reagent]) -> void:
	for reagent: Reagent in reagents:
		EventBus.game_events.task_completed.emit(tool_template, reagent)
