class_name ReagentCounter
extends MarginContainer

@export var _desirable_color: Color
@export var _undesirable_color: Color
@export var _stable_color: Color

@onready var texture_progress_rect: TextureProgressBar = %TextureProgressRect
@onready var icon: TextureRect = %Icon


func update(reagent: Reagent) -> void:
	icon.texture = reagent.icon

enum TimerColor {
	DESIRABLE,
	UNDESIRABLE,
	STABLE,
}

func set_color(color_options: TimerColor) -> void:
	match color_options:
		TimerColor.STABLE: texture_progress_rect.self_modulate = _stable_color
		TimerColor.DESIRABLE: texture_progress_rect.self_modulate = _desirable_color
		TimerColor.UNDESIRABLE: texture_progress_rect.self_modulate = _undesirable_color
