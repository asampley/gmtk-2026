extends PanelContainer

@onready var help_panes: Control = %HelpPanes

@onready var button_prev: Button = %Prev
@onready var button_next: Button = %Next
@onready var button_close: Button = %Close
var current_pane := 0

func _ready() -> void:
	for pane in help_panes.get_children():
		pane.visible = false

	show_pane(current_pane)

func show_pane(i: int) -> void:
	var children := help_panes.get_children()

	if help_panes.get_children().size() > 0:
		children[current_pane].visible = false;

		current_pane = clampi(i, 0, children.size() - 1)

		children[current_pane].visible = true;

	button_prev.disabled = current_pane == 0
	button_next.disabled = current_pane == children.size() - 1

func _on_next_pressed() -> void:
	show_pane(current_pane + 1)

func _on_prev_pressed() -> void:
	show_pane(current_pane - 1)

func _on_close_pressed() -> void:
	self.visible = false
	show_pane(0)
