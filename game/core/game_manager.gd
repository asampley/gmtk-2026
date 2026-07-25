class_name GameManager
extends Node


@export var starting_level: LevelTemplate

@onready var level_parent: CanvasLayer = %LevelParent
@onready var hud_layer: CanvasLayer = %HudLayer
@onready var pause_layer: CanvasLayer = %PauseLayer
@onready var menu_layer: MenuLayer = %MenuLayer
@onready var transition_layer: TransitionManager = %TransitionLayer
@onready var debug_layer: CanvasLayer = %DebugLayer
@onready var music_manager: MusicManager = %MusicManager


var current_level: LevelTemplate
var level_scene: Level
var recipes: Array[Recipe]

signal game_manager_loaded()


func _ready() -> void:
	ServiceLocator.game_manager = self
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	for resource: Resource in ResourceDataHandler.resource_dict["recipes"]:
		if resource is Recipe:
			recipes.append(resource)
	
	for resource: Resource in ResourceDataHandler.resource_dict["recipes_decay"]:
		if resource is Recipe:
			recipes.append(resource)
	
	game_manager_loaded.emit()
	load_level(starting_level)
	music_manager.play()

func load_level(level_template: LevelTemplate) -> void:
	transition_layer.begin_transition()
	_deferred_load_level.call_deferred(level_template)
	
	await transition_layer.fade_completed
	transition_layer.end_transition()
	menu_layer.hide_children()

func _deferred_load_level(level_template: LevelTemplate) -> void:
	if level_scene:
		level_scene.queue_free()
	await get_tree().process_frame
	level_scene = level_template.level_scene.instantiate()
	
	if level_scene == null:
		push_error("Loaded level is not type Level or does not exist.")
		return
	level_parent.add_child(level_scene)
	current_level = level_template
	level_scene.initialize(current_level)

func _on_level_complete_menu_next_level_requested() -> void:
	load_level(current_level.next_level)
