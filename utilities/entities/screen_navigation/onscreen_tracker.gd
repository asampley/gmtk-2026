class_name OffscreenTimeout
extends VisibleOnScreenNotifier2D


@export var timeout_s: float = 5.0
@export var sprite: Sprite2D

var lifespawn_seconds: float
var onscreen: bool

signal timed_out()


func _ready() -> void:
	rect = sprite.get_rect()
	screen_entered.connect(func() -> void: onscreen = true)
	screen_exited.connect(func() -> void: onscreen = false)

func _physics_process(delta: float) -> void:
	if onscreen:
		lifespawn_seconds = 0
		return
	
	lifespawn_seconds += delta
	if lifespawn_seconds >= timeout_s:
		timed_out.emit()
