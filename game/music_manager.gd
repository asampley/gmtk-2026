class_name MusicManager
extends Node


@export var transition_time_s: float = 3
@export var max_volume: float = 1.5

var tween: Tween


func _ready() -> void:
	EventBus.audio_events.music_bus_audible.connect(on_music_bus_audible)
	EventBus.audio_events.music_bus_muted.connect(on_music_bus_muted)

func play() -> void:
	for child: AudioStreamPlayer in get_children():
		child.playing = true

func _physics_process(delta: float) -> void:
	var index: int = AudioServer.get_bus_index("Cauldron")

func on_music_bus_audible(bus_name: String) -> void:
	var index: int = AudioServer.get_bus_index(bus_name)
	if tween:
		tween.kill()
	var current_volume := AudioServer.get_bus_volume_linear(index)
	var callable_tween_music := tween_music.bind(index)
	tween = create_tween()
	tween.tween_method(callable_tween_music, current_volume, max_volume, transition_time_s)

func on_music_bus_muted(bus_name: String) -> void:
	var index: int = AudioServer.get_bus_index(bus_name)
	if tween:
		tween.kill()
	var current_volume := AudioServer.get_bus_volume_linear(index)
	var callable_tween_music := tween_music.bind(index)
	tween = create_tween()
	tween.tween_method(callable_tween_music, current_volume, 0, transition_time_s)

func tween_music(volume: float, index: int) -> void:
	AudioServer.set_bus_volume_linear(index, volume)
	print(AudioServer.get_bus_name(index))
	
