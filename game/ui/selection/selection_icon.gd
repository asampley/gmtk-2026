class_name SelectionIcon
extends TextureRect


func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	set_size(Vector2(64,64))

func set_icon(texture_in: Texture2D) -> void:
	texture = texture_in

func _process(delta: float) -> void:
	global_position = get_global_mouse_position() - Vector2(size.x / 2 - 15, 30)
