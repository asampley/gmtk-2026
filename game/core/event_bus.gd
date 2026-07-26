extends Node


@warning_ignore_start("unused_signal")

var game_events := GameEvents.new()
var ui_events := UIEvents.new()
var audio_events := AudioEvents.new()
var debug_events := DebugEvents.new()
var setup_events := SetupEvents.new()
enum SFX {AFFIRMATIVE, NEGATIVE}

class GameEvents:
	signal task_completed(tool: ToolTemplate, reagent: Reagent)
	signal popup_requested(index: int)
	signal level_completed()

class UIEvents:
	signal fly_in_text_requested(text: String, index: int, position: Vector2, impact: float, direction: Vector2)

class AudioEvents:
	signal ui_audio_played(sound: AudioStream)
	signal sfx_request(sfx_type: SFX)
	signal music_bus_audible(bus_name: String)
	signal music_bus_muted(bus_name: String)

class DebugEvents:
	signal toggle_fps_counter()

class SetupEvents:
	signal player_identified()
	signal preloading_completed()

@warning_ignore_restore("unused_signal")
