extends Node


@warning_ignore_start("unused_signal")

var game_events := GameEvents.new()
var ui_events := UIEvents.new()
var audio_events := AudioEvents.new()
var debug_events := DebugEvents.new()
var setup_events := SetupEvents.new()


class GameEvents:
	signal task_completed(index: int)

class UIEvents:
	signal fly_in_text_requested(text: String, position: Vector2, impact: float, direction: Vector2)

class AudioEvents:
	signal ui_audio_played(sound: AudioStream)

class DebugEvents:
	signal toggle_fps_counter()

class SetupEvents:
	signal player_identified()
	signal preloading_completed()

@warning_ignore_restore("unused_signal")
