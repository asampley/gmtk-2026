extends AudioStreamPlayer


@export var ahha_sounds: Array[AudioStream] = []
@export var hmm_sounds: Array[AudioStream] = []
@export var grumpy_sounds: Array[AudioStream] = []
@export var no_sounds: Array[AudioStream] = []
@export var oh_sounds: Array[AudioStream] = []
@export var uhuh_sounds: Array[AudioStream] = []
@export var whimsy_sounds: Array[AudioStream] = []
@export var random: float = 0.7

var combined_affirmative: Array[AudioStream] = []
var combined_negative: Array[AudioStream] = []


func _ready() -> void:
	EventBus.audio_events.sfx_request.connect(_on_sfx_request)
	max_polyphony = 4
	combined_affirmative.append_array(ahha_sounds)
	combined_affirmative.append_array(hmm_sounds)
	combined_affirmative.append_array(whimsy_sounds)
	combined_affirmative.append_array(oh_sounds)
	combined_negative.append_array(grumpy_sounds)
	combined_negative.append_array(uhuh_sounds)

func _on_sfx_request(sfx_type: EventBus.SFX) -> void:
	var sounds_to_play: Array[AudioStream] = []
	var chosen_sound: AudioStream
	
	if sfx_type == EventBus.SFX.AFFIRMATIVE:
		if randf_range(0,1.0) < random:
			sounds_to_play = combined_affirmative
	elif sfx_type == EventBus.SFX.NEGATIVE:
		sounds_to_play = combined_negative

	
	if !sounds_to_play.is_empty():
		chosen_sound = sounds_to_play.pick_random()
		stream = chosen_sound
		play()
