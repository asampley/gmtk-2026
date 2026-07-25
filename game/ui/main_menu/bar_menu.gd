extends Control

signal sound_settings()
signal recipe_book()
signal help()
signal level_select()

func _on_sound_pressed() -> void:
	sound_settings.emit()

func _on_recipe_pressed() -> void:
	recipe_book.emit()

func _on_help_pressed() -> void:
	help.emit()

func _on_level_select_pressed() -> void:
	level_select.emit()
