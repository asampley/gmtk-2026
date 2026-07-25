extends PanelContainer


signal next_level_requested()


func _ready() -> void:
	hide()
	EventBus.game_events.level_completed.connect(show)

func _on_next_level_button_pressed() -> void:
	next_level_requested.emit()
