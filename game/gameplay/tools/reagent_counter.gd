class_name ReagentCounter
extends MarginContainer


@onready var texture_progress_rect: TextureProgressBar = %TextureProgressRect
@onready var icon: TextureRect = %Icon


func update(reagent: Reagent) -> void:
	icon.texture = reagent.icon
