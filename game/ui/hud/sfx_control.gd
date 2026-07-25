extends HSlider

var sfx_bus := AudioServer.get_bus_index("Game_Audio")

func _on_ready() -> void:
	_on_value_changed(value)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
