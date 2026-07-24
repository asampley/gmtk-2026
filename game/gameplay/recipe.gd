class_name Recipe
extends Resource

@export var name: String
@export var reagents: Array[Reagent]
@export var catalysts: Array[Catalyst]
@export var products: Array[Reagent]
@export var tool_template: ToolTemplate
@export var time: float

@export var desirable: bool = true
