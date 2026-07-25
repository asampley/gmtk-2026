extends Button


func _on_pressed() -> void:
	EventBus.audio_events.sfx_request.emit(EventBus.SFX.HMM)
