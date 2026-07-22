class_name AdvancedButton
extends Button


@export var hover_animations: UIAnimationData
@export var hover_audio: AudioStream
@export var pressed_animations: UIAnimationData
@export var pressed_audio: AudioStream

var hover_animatable: Animatable = Animatable.new()
var pressed_animatable: Animatable = Animatable.new()
var hover_audio_player: AudioStreamPlayer
var pressed_audio_player: AudioStreamPlayer


func _ready() -> void:
	pivot_offset = size * Vector2(0.5, 0.5)

	hover_audio_player = AudioStreamPlayer.new()
	add_child(hover_audio_player)
	hover_audio_player.stream = hover_audio
	if hover_animations:
		hover_animatable.initialize(self, hover_animations)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
	pressed_audio_player = AudioStreamPlayer.new()
	add_child(pressed_audio_player)
	pressed_audio_player.stream = pressed_audio
	if pressed_animations:
		pressed_animatable.initialize(self, pressed_animations)
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)

func on_mouse_entered() -> void:
	hover_audio_player.play()
	hover_animatable.on_trigger(true)

func on_mouse_exited() -> void:
	hover_animatable.on_trigger(false)

func on_button_down() -> void:
	pressed_audio_player.play()
	pressed_animatable.on_trigger(true)

func on_button_up() -> void:
	pressed_animatable.on_trigger(false)
