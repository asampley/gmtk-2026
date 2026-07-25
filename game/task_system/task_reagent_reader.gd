class_name TaskReagentReader
extends ReagentReader


func _on_updated_reagents(reagents: Array[Reagent]) -> void:
	for reagent: Reagent in reagents:
		EventBus.game_events.task_completed.emit(reagent_to_index[reagent])
