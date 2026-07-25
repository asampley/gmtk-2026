extends HSlider

var music_bus := AudioServer.get_bus_index("Music")

func _on_ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
