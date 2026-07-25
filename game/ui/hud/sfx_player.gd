extends AudioStreamPlayer

@export var ahha_sounds: Array[AudioStream] = []
@export var hmm_sounds: Array[AudioStream] = []
@export var grumpy_sounds: Array[AudioStream] = []
@export var no_sounds: Array[AudioStream] = []
@export var oh_sounds: Array[AudioStream] = []
@export var uhuh_sounds: Array[AudioStream] = []
@export var whimsy_sounds: Array[AudioStream] = []

func _ready() -> void:
	EventBus.audio_events.sfx_request.connect(_on_sfx_request)
	max_polyphony = 4

func _on_sfx_request(sfx_type: EventBus.SFX) -> void:
	var sounds_to_play: Array[AudioStream] = []
	var chosen_sound: AudioStream
	
	if sfx_type == EventBus.SFX.AHHA:
		sounds_to_play = ahha_sounds
	elif sfx_type == EventBus.SFX.HMM:
		sounds_to_play = hmm_sounds
	elif sfx_type == EventBus.SFX.GRUMPY:
		sounds_to_play = grumpy_sounds
	elif sfx_type == EventBus.SFX.NO:
		sounds_to_play = no_sounds
	elif sfx_type == EventBus.SFX.OH:
		sounds_to_play = oh_sounds
	elif sfx_type == EventBus.SFX.UHUH:
		sounds_to_play = uhuh_sounds
	elif sfx_type == EventBus.SFX.WHIMSY:
		sounds_to_play = whimsy_sounds
	
	if !sounds_to_play.is_empty():
		chosen_sound = sounds_to_play.pick_random()
		stream = chosen_sound
		play()
