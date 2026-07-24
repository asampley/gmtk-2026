class_name GameManager
extends Node


@onready var level_parent: CanvasLayer = %LevelParent
@onready var hud_layer: CanvasLayer = %HudLayer
@onready var pause_layer: CanvasLayer = %PauseLayer
@onready var menu_layer: CanvasLayer = %MenuLayer
@onready var transition_layer: TransitionManager = %TransitionLayer
@onready var debug_layer: CanvasLayer = %DebugLayer


var current_level: LevelTemplate
var level_scene: Level

signal game_manager_loaded()


func _ready() -> void:
	ServiceLocator.game_manager = self
	game_manager_loaded.emit()

func load_level(level_template: LevelTemplate) -> void:
	transition_layer.begin_transition()
	_deferred_load_level.call_deferred(level_template)
	transition_layer.end_transition()
	menu_layer.hide()

func _deferred_load_level(level_template: LevelTemplate) -> void:
	if level_scene:
		level_scene.queue_free()
	await get_tree().process_frame
	level_scene = level_template.level_scene.instantiate()

	if level_scene == null:
		push_error("Loaded level is not type Level or does not exist.")
		return
	level_parent.add_child(level_scene)


func _on_mute_button_pressed() -> void:
	pass # Replace with function body.
