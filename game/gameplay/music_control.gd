class_name MusicControl
extends AudioStreamPlayer


@export var transition_time_s: float = 3
@export var transition_time_2_s: float = 0.5
@export var max_volume: float = 1.0
@export var vocals_volume_mult: float = 0.1
@export var this_bus_name: String

var tween: Tween
var all_buses: Array[String] = ["Cauldron", "Crucible", "Knife", "Mortar"]



func _ready() -> void:
	EventBus.audio_events.music_bus_audible.connect(on_music_bus_audible)
	EventBus.audio_events.music_bus_muted.connect(on_music_bus_muted)

func on_music_bus_audible(bus_name: String) -> void:
	if !(bus_name == this_bus_name):
		return
	var index: int = AudioServer.get_bus_index(this_bus_name)
	if tween:
		tween.kill()
	var current_volume := AudioServer.get_bus_volume_linear(index)
	var callable_tween_music := tween_music.bind(index)
	tween = create_tween()
	tween.tween_method(callable_tween_music, current_volume, max_volume, transition_time_s)

func on_music_bus_muted(bus_name: String) -> void:
	if !(bus_name == this_bus_name):
		return
	var index: int = AudioServer.get_bus_index(bus_name)
	if tween:
		tween.kill()
	var current_volume := AudioServer.get_bus_volume_linear(index)
	var callable_tween_music := tween_music.bind(index)
	tween = create_tween()
	tween.tween_method(callable_tween_music, current_volume, 0, transition_time_2_s)

func tween_music(volume: float, index: int) -> void:
	AudioServer.set_bus_volume_linear(index, volume)
	var total_volume: float = 0.0
	for bus_name: String in all_buses:
		var i: int = AudioServer.get_bus_index(bus_name)
		var current_volume := AudioServer.get_bus_volume_linear(index)
		total_volume += current_volume
	var vocal_index: int = AudioServer.get_bus_index("Vocals")
	AudioServer.set_bus_volume_linear(vocal_index, (total_volume / 4) * vocals_volume_mult)
