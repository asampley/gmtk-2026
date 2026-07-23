class_name RecipeDiagram
extends Control

@onready var title: RichTextLabel = %Title
@onready var tool_icon: TextureRect = %ToolIcon
@onready var reaction_icon: Control = %ReactionIcon
@onready var recipe_reagents: Control = %RecipeReagents
@onready var recipe_products: Control = %RecipeProducts

func render_recipe(recipe: Recipe) -> void:
	for child in recipe_reagents.get_children():
		child.queue_free()
	for child in recipe_products.get_children():
		child.queue_free()

	reaction_icon.visible = recipe != null

	if recipe == null:
		title.text = "";
		tool_icon.texture = null;
	else:
		title.text = recipe.name
		tool_icon.texture = recipe.tool_template.icon

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
