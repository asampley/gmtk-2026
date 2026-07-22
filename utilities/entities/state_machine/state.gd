class_name State
extends Node

 
var black_board: BlackBoard
var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_node: Node


func initialize(base_node_in: Node, black_board_in: BlackBoard) -> void:
	base_node = base_node_in
	black_board = black_board_in

func validate_base_node_class(required_class: String) -> bool:
	if !(base_node.is_class(required_class)):
		printerr("State {0} assigned a base node {1} that is not a {2}."\
			.format([name, base_node.name, required_class]))
		return false
	return true

func validate_base_node_vars(required_vars: Array[String]) -> bool:
	for v: String in required_vars:
		if !(v in base_node):
			printerr("State {0} assigned a base node {1} missing {2} var."\
				.format([name, base_node.name, v]))
			return false
	return true

func validate_base_node_funcs(required_funcs: Array[String]) -> bool:
	for f: String in required_funcs:
		if !(base_node.has_method(f)):
			printerr("State {0} assigned a base node {1} missing {2} func."\
			 .format([name, base_node.name, f]))
			return false
	return true

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
