class_name ButtonClickAudioPlayer
extends Node


@export var sound: AudioStream


func _ready() -> void:
	var parent := get_parent()
	if parent is Button:
		parent.pressed.connect(on_button_pressed)

func on_button_pressed() -> void:
	EventBus.audio_events.ui_audio_played.emit(sound)
