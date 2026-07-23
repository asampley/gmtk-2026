extends Control


var recipes: Array[Recipe]

var page_flip: int = 0
@onready var page_left: RecipeDiagram = %RecipeLeft
@onready var page_right: RecipeDiagram = %RecipeRight

func _ready() -> void:
	for resource: Resource in ResourceDataHandler.resource_dict["recipes"]:
		recipes.append(resource as Recipe)

	render_recipes()

func render_recipes() -> void:
	if recipes.size() > page_flip * 2:
		_render_recipe(page_left, recipes[page_flip * 2])

	if recipes.size() > page_flip * 2 + 1:
		_render_recipe(page_right, recipes[page_flip * 2 + 1])

static func _render_recipe(page: RecipeDiagram, recipe: Recipe) -> void:
	page.render_recipe(recipe)
