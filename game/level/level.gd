class_name Level
extends Node


@export var tools: Array[Tool]
@export var recipes: Array[Recipe]
@export var time_limit_s: float = 0


var selection_manager := SelectionManager.new()
var time_elapsed_s: float
var cauldron_recipes: Array[Recipe]

func _ready() -> void:
	var selection_icon := SelectionIcon.new()
	add_child(selection_icon)
	selection_icon.size = Vector2(100,100)
	selection_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	selection_manager.initialize(selection_icon)
	time_elapsed_s = 0
	initialize_tool_recipe_arrays()
	initialize_tools()

func _process(delta: float) -> void:
	if time_elapsed_s <= 0:
		return

	time_elapsed_s += delta
	if time_elapsed_s >= time_elapsed_s:
		print_debug("Level Lost")

func initialize_tool_recipe_arrays() -> void:
	for recipe: Recipe in ResourceDataHandler.resource_dict["recipes"]:
		if recipe.tool_template.name == "Cauldron":
			cauldron_recipes.append(recipe)

func initialize_tools() -> void:
	for tool: Tool in tools:
		tool.initialize(selection_manager)
