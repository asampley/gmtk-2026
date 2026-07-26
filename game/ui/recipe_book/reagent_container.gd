class_name ReagentContainer
extends PanelContainer


@onready var texture_rect: TextureRect = %TextureRect


func initialize(icon: Texture2D) -> void:
	texture_rect.texture = icon
