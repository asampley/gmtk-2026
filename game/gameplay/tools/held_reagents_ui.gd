class_name HeldReagentsUI
extends HBoxContainer


@export var reagent_counter_prefab: PackedScene

var reagent_to_counter: Dictionary[Reagent, ReagentCounter] = {}
var reaction_progress_view: ReactionProgress


func initialize(tool_in: Tool) -> void:
	tool_in.updated_reagents.connect(_on_updated_reagents)
	tool_in.updated_reactions.connect(_on_updated_reactions)

func _on_updated_reagents(reagents: Array[Reagent]) -> void:
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

func _on_updated_reactions(reaction_progress: ReactionProgress) -> void:
	reaction_progress_view = reaction_progress

func _process(delta: float) -> void:
	for reagent in reagent_to_counter:
		var time_remaining := INF
		var progress := 0.0
		var desireable := true

		for recipe in reaction_progress_view.recipe_progress:
			var rp := reaction_progress_view.recipe_progress[recipe]

			if rp.paused:
				continue

			if recipe.reagents.has(reagent):
				if rp.estimated_remaining < time_remaining:
					time_remaining = rp.estimated_remaining
					progress = rp.progress
					desireable = recipe.desirable

		var reagent_counter := reagent_to_counter[reagent]
		reagent_counter.texture_progress_rect.value = 1.0 - progress
		if time_remaining == INF:
			reagent_counter.set_color(ReagentCounter.TimerColor.STABLE)
		elif desireable:
			reagent_counter.set_color(ReagentCounter.TimerColor.DESIRABLE)
		else:
			reagent_counter.set_color(ReagentCounter.TimerColor.UNDESIRABLE)
