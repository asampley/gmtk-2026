extends Control

@export var help_menu: Control

func _ready() -> void:
	assert(help_menu != null)

func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_help_button_pressed() -> void:
	print("here")
	help_menu.visible = true

func _on_play_button_pressed() -> void:
	pass # Replace with function body.
