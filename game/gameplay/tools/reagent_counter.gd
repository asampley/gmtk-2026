class_name ReagentCounter
extends Container

@export var _desirable_color: Color
@export var _undesirable_color: Color
@export var _stable_color: Color
@export var _segments: int = 6
@export var _reaction_texture: Texture
@export var _stable_texture: Texture

@onready var texture_progress_rect: TextureProgressBar = %TextureProgressRect
@onready var icon: TextureRect = %Icon
@onready var overflow_number: RichTextLabel = %OverflowNumber

var stable: bool:
	set(value):
		stable = value
		_update_color()
var desirable: bool:
	set(value):
		desirable = value
		_update_color()

func update(reagent: Reagent) -> void:
	icon.texture = reagent.icon

func _update_color() -> void:
	if stable:
		texture_progress_rect.texture_progress = _stable_texture
		texture_progress_rect.self_modulate = _stable_color
	elif desirable:
		texture_progress_rect.texture_progress = _reaction_texture
		texture_progress_rect.self_modulate = _desirable_color
	else:
		texture_progress_rect.self_modulate = _undesirable_color

func set_full() -> void:
	overflow_number.text = ""
	texture_progress_rect.value = 1.0

func set_remaining(remaining: int) -> void:
	if remaining > _segments:
		overflow_number.text = "[b]" + str(remaining) + "[/b]"
		texture_progress_rect.value = 1.0
	else:
		overflow_number.text = ""
		texture_progress_rect.value = (remaining as float) / _segments
