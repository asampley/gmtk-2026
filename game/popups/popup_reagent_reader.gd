class_name PopupReagentReader
extends ReagentReader


func _on_updated_reagents(reagents: Array[Reagent]) -> void:
	for reagent: Reagent in reagents:
		if reagent_to_index.has(reagent):
			EventBus.game_events.popup_requested.emit(reagent_to_index[reagent])
