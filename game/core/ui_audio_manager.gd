extends AudioStreamPlayer


func _ready() -> void:
	EventBus.audio_events.ui_audio_played.connect(on_ui_audio_played)
	play()

func on_ui_audio_played(sound: AudioStream) -> void:
	get_stream_playback().play_stream(sound)
