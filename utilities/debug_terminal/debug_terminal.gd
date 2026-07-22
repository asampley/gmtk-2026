extends Control


@onready var line_edit: LineEdit = %LineEdit
@onready var parent: VBoxContainer = %Parent


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_debug_terminal"):
		toggle_terminal()

func toggle_terminal() -> void:
	visible = !visible
	if visible:
		line_edit.edit()

func _on_line_edit_text_submitted(new_text: String) -> void:
	match new_text:
		"fps":
			EventBus.debug_events.toggle_fps_counter.emit()
		"die":
			EventBus.debug_events.die.emit()
		_:
			new_text = "Invalid Command"
	update_command_history(new_text)

func update_command_history(new_text: String) -> void:
	line_edit.clear()
	if parent.get_children().size() >= 5:
		parent.get_children()[0].queue_free()
	var label := Label.new()
	parent.add_child(label)
	label.text = new_text
	line_edit.edit()
