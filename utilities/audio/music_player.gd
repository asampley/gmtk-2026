extends AudioStreamPlayer


@export var tween_time_seconds: float = 0.0
@export var master_volume_db: float = -5

@export var low_pass_filter_quiet_hz: float = 300
@export var low_pass_filter_loud_hz: float = 2000
@export var volume_quiet_db: float = -15
@export var volume_loud_db: float = -5


var master_bus_index: int



func _init() -> void:
	master_bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus_index, -100)
	EventBus.game_events.game_ended.connect(on_game_ended)
	EventBus.game_events.game_reset.connect(on_game_reset)
	EventBus.setup_events.preloading_completed.connect(on_preloading_completed)

func on_preloading_completed() -> void:
	playing = true
	AudioServer.set_bus_volume_db(master_bus_index, master_volume_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume_quiet_db)
	volume_db = volume_loud_db
	var filter: AudioEffectLowPassFilter = AudioServer.get_bus_effect(master_bus_index, 0)
	filter.cutoff_hz = low_pass_filter_loud_hz

func on_game_ended() -> void:
	tween_low_pass_filter(low_pass_filter_quiet_hz)
	tween_volume(volume_quiet_db)

func on_game_reset() -> void:
	tween_low_pass_filter(low_pass_filter_loud_hz)
	tween_volume(volume_loud_db)

func tween_low_pass_filter(hz: float) -> void:
	var tween := create_tween()
	var filter: AudioEffectLowPassFilter = AudioServer.get_bus_effect(master_bus_index, 0)
	await tween.tween_property(filter, "cutoff_hz", hz, tween_time_seconds).finished
	
	tween.kill()

func tween_volume(db: float) -> void:
	var tween := create_tween()
	await tween.tween_property(self, "volume_db", db, tween_time_seconds).finished
	
	tween.kill()
