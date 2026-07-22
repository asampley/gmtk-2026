extends Control

@onready var help_menu: Control = %HelpMenu
@onready var level_select: Control = %LevelSelect

func _on_credits_button_pressed() -> void:
	pass

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_help_button_pressed() -> void:
	self.visible = true
	help_menu.visible = true

func _on_play_button_pressed() -> void:
	self.visible = true
	level_select.visible = true

func _on_close_pressed() -> void:
	self.visible = false

	help_menu.visible = false
	level_select.visible = false
