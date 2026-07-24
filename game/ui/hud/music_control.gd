extends HSlider

var sfx_bus := AudioServer.get_bus_index("Game_Audio")

func _on_ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
