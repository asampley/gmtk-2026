extends Control


@export var index_to_popup: Dictionary[int, PopupUI] = {}


func _ready() -> void:
	EventBus.game_events.popup_requested.connect(on_popup_requested)
	for child: PopupUI in get_children():
		child.hide()

func on_popup_requested(index: int) -> void:
	for child: PopupUI in get_children():
		child.hide()
	if index_to_popup.has(index):
		index_to_popup[index].show()
