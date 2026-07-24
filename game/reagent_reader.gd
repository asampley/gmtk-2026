class_name ReagentReader
extends Node


@export var reagent_to_index: Dictionary[Reagent, int] = {}


func initialize(tool_in: Tool) -> void:
	tool_in.updated_reagents.connect(_on_updated_reagents)

func _on_updated_reagents(reagents: Array[Reagent]) -> void:
	pass
