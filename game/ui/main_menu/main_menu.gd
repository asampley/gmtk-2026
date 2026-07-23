extends CanvasLayer


@onready var buttons: Control = %Buttons
@onready var sub_menu: Control = %SubMenu


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_help_button_pressed() -> void:
	pass

func _on_play_button_pressed() -> void:
	pass

func _on_sub_menu_visibility_changed() -> void:
	buttons.visible = !sub_menu.visible
