class_name HeldReagentsUI
extends HBoxContainer


@export var reagent_counter_prefab: PackedScene 

var reagent_to_counter: Dictionary[Reagent, ReagentCounter] = {}


func initialize(tool_in: Tool) -> void:
	tool_in.updated_reagents.connect(on_updated_reagents)

func on_updated_reagents(reagents: Array[Reagent]) -> void:
	for reagent: Reagent in reagents:
		if reagent_to_counter.has(reagent):
			reagent_to_counter[reagent].update(reagent)
		else:
			var reagent_counter_ui: ReagentCounter = reagent_counter_prefab.instantiate()
			reagent_to_counter[reagent] = reagent_counter_ui
			add_child(reagent_counter_ui)
			reagent_counter_ui.update(reagent)
	var keys := reagent_to_counter.keys()
	for key: Reagent in keys:
		if !reagents.has(key):
			remove_child(reagent_to_counter[key])
			reagent_to_counter.erase(key)
