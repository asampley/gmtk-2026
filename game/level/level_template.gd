class_name LevelTemplate
extends Resource


@export var level_name: String
@export var level_scene: PackedScene
@export var next_level: LevelTemplate

@export var enabled_devices: Array[ToolTemplate]
@export var tasks: Array[TaskTemplate]
