extends Control


var recipes: Array[Recipe]

var page_flip: int = 0
@onready var page_left: RecipeDiagram = %RecipeLeft
@onready var page_right: RecipeDiagram = %RecipeRight
@onready var turn_page_forward: Button = %TurnPageForward
@onready var turn_page_backward: Button = %TurnPageBackward

static func _render_recipe(page: RecipeDiagram, recipe: Recipe) -> void:
	page.render_recipe(recipe)

func _ready() -> void:
	for resource: Resource in ResourceDataHandler.resource_dict["recipes"]:
		recipes.append(resource as Recipe)

	set_page_flip(0)
	render_recipes()

func render_recipes() -> void:
	if recipes.size() > page_flip * 2:
		_render_recipe(page_left, recipes[page_flip * 2])
	else:
		_render_recipe(page_left, null)

	if recipes.size() > page_flip * 2 + 1:
		_render_recipe(page_right, recipes[page_flip * 2 + 1])
	else:
		_render_recipe(page_right, null)

func _on_close_pressed() -> void:
	visible = false

func _on_turn_page_forward_pressed() -> void:
	set_page_flip(page_flip + 1)

func _on_turn_page_backward_pressed() -> void:
	set_page_flip(page_flip - 1)

func set_page_flip(i: int) -> void:
	page_flip = clamp(0, (recipes.size() + 1) / 2, i)
	turn_page_forward.disabled = page_flip >= (recipes.size() - 1) / 2
	turn_page_backward.disabled = page_flip == 0
