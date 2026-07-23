class_name SelectionIcon
extends TextureRect


func _ready() -> void:
	pass

func set_icon(texture_in: Texture2D) -> void:
	texture = texture_in

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
