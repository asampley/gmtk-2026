class_name TaskSignalReader
extends Node


@export var reagent_to_index: Dictionary[Reagent, int] = {}


func initialize(tool_in: Tool) -> void:
	tool_in.updated_reagents.connect(on_updated_reagents)

func on_updated_reagents(reagents: Array[Reagent]) -> void:
	for reagent: Reagent in reagents:
		if reagent_to_index.has(reagent):
			EventBus.game_events.task_completed.emit(reagent_to_index[reagent])
