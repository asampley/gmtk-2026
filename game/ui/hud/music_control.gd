extends HSlider

var music_bus := AudioServer.get_bus_index("Music")

func _on_ready() -> void:
	_on_value_changed(value)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
