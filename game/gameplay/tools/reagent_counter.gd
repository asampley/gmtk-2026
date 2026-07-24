class_name ReagentCounter
extends MarginContainer

@export var _desirable_color: Color
@export var _undesirable_color: Color
@export var _stable_color: Color

@onready var texture_progress_rect: TextureProgressBar = %TextureProgressRect
@onready var icon: TextureRect = %Icon


func update(reagent: Reagent, reaction_progress: ReactionProgress) -> void:
	icon.texture = reagent.icon
	var color_options: ReactionProgress.ReagentState = reaction_progress.reagent_state
	match color_options:
		ReactionProgress.ReagentState.STABLE: texture_progress_rect.self_modulate = _stable_color
		ReactionProgress.ReagentState.DESIRABLE: texture_progress_rect.self_modulate = _desirable_color
		ReactionProgress.ReagentState.UNDESIRABLE: texture_progress_rect.self_modulate = _undesirable_color
