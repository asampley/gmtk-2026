extends Control


@export var index_to_popup: Dictionary[int, PopupUI] = {}


func _ready() -> void:
	EventBus.game_events.popup_requested.connect(on_popup_requested)

func on_popup_requested(index: int) -> void:
	for child: PopupUI in get_children():
		child.hide()
	index_to_popup[index].show()
