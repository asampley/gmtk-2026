class_name RecipeDiagram
extends Control

@onready var title: RichTextLabel = %Title
@onready var tool_icon: TextureRect = %ToolIcon
@onready var recipe_reagents: Control = %RecipeReagents
@onready var recipe_products: Control = %RecipeProducts

func render_recipe(recipe: Recipe) -> void:
	print("Rendering recipe: ", recipe)

	title.text = recipe.name
	tool_icon.texture = recipe.tool.icon

	for child in recipe_reagents.get_children():
		child.queue_free()
	for child in recipe_products.get_children():
		child.queue_free()

	for reagent in recipe.reagents:
		var texture_rect := TextureRect.new()
		texture_rect.texture = reagent.icon
		recipe_reagents.add_child(texture_rect)
		print(reagent)

	for product in recipe.products:
		var texture_rect := TextureRect.new()
		texture_rect.texture = product.icon
		recipe_products.add_child(texture_rect)
		print(product)
