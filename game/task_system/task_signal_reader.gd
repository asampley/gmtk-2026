class_name TaskSignalReader
extends Node


@export var reagent_to_index: Dictionary[Reagent, int] = {}


func initialize(tool_in: Tool) -> void:
	tool_in.updated_reagents.connect(on_updated_reagents)

func on_updated_reagents(reagents_to_progress: Dictionary[Reagent, ReactionProgress]) -> void:
	for reagent: Reagent in reagents_to_progress.keys():
		if reagent_to_index.has(reagent):
			EventBus.game_events.task_completed.emit(reagent_to_index[reagent])
