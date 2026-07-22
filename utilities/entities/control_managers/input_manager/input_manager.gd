class_name InputManager
extends ControlManager


func _unhandled_key_input(event: InputEvent) -> void:
	#if event.is_action_released("move"):
		#movement_set.emit(false, Vector2.ZERO)
	#elif event.is_action("move"):
		#movement_set.emit(true, Vector2.ZERO)
	pass
