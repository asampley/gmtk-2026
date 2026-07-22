@tool
class_name AnimationContainer
extends AnimationControl


func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()

func update_layout() -> void:
	var content_rect := Rect2(Vector2(), size)
	for child in get_children():
		if child is Control && child.visible:
			fit_child_in_rect(child, content_rect)
