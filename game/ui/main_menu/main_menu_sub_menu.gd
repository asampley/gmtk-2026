extends Control


@export var level_button_prefab: PackedScene

@onready var help_menu: Control = %HelpMenu
@onready var level_select: Control = %LevelSelect
@onready var credits: Control = %Credits
@onready var recipe_book: Control = %RecipeBook
@onready var sound_settings: Control = %SoundSettings

func _ready() -> void:
	_hide_all()

func _open(control: Control) -> void:
	print("Open menu: ", control)
	self.visible = true
	control.visible = true

func close() -> void:
	self.visible = false
	_hide_all()

func open_help() -> void:
	_open(help_menu)

func open_level_select() -> void:
	_open(level_select)

func open_credits() -> void:
	_open(credits)

func open_recipes() -> void:
	_open(recipe_book)

func open_sound_settings() -> void:
	_open(sound_settings)

func _hide_all() -> void:
	help_menu.visible = false
	level_select.visible = false
	credits.visible = false
	recipe_book.visible = false
	sound_settings.visible = false
