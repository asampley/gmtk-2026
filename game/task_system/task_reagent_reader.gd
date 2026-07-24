class_name TaskReagentReader
extends ReagentReader


func _on_updated_reagents(reagents_to_progress: Dictionary[Reagent, ReactionProgress]) -> void:
	for reagent: Reagent in reagents_to_progress.keys():
		if reagent_to_index.has(reagent):
			EventBus.game_events.task_completed.emit(reagent_to_index[reagent])
