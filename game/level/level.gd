class_name Level
extends Node


@export var recipes: Array[Recipe]
@export var time_limit_s: float = 0

var time_elapsed_s: float
var cauldron_recipes: Array[Recipe]

func _ready() -> void:
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
	pass
