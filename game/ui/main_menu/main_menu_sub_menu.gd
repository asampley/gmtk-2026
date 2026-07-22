extends Control


@export var level_button_prefab: PackedScene

@onready var help_menu: Control = %HelpMenu
@onready var level_select_parent: Control = %LevelSelect


func _ready() -> void:
	_hide_all()

func _on_credits_button_pressed() -> void:
	pass

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

func _on_help_button_pressed() -> void:
	self.visible = true
	help_menu.visible = true

func _on_play_button_pressed() -> void:
	self.visible = true
	level_select_parent.visible = true
	for child: Node in level_select_parent:
		child.queue_free()
	for level: LevelTemplate in ResourceDataHandler.resource_dict["levels"]:
		var button: Button = level_button_prefab.instantiate()
		level_select_parent.add_child(button)
		button.pressed.connect(ServiceLocator.game_manager.load_level.bind(level))

func _on_close_pressed() -> void:
	self.visible = false

	_hide_all()

func _hide_all() -> void:
	help_menu.visible = false
	level_select_parent.visible = false
