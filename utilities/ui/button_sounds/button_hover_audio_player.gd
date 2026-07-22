class_name ButtonHoverAudioPlayer
extends Node


@export var sound: AudioStream


func _ready() -> void:
	var parent := get_parent()
	if parent is Button:
		parent.mouse_entered.connect(on_mouse_entered)

func on_mouse_entered() -> void:
	EventBus.audio_events.ui_audio_played.emit(sound)
