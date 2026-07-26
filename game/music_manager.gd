class_name MusicManager
extends Node

@export var music_controllers: Array[MusicControl]


var tween: Tween


func play() -> void:
	for child: AudioStreamPlayer in get_children():
		child.playing = true

func reset_buses() -> void:
	for child: MusicControl in music_controllers:
		child.playing = true
		child.on_music_bus_muted(child.this_bus_name)
