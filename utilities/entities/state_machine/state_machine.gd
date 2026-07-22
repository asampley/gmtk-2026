class_name StateMachine
extends Node


@export var is_active: bool = false
@export var starting_state: State
@export var black_board: BlackBoard = BlackBoard.new()

var current_state: State


func initialize(base_node_in: Node) -> void:
	for child: State in get_children():
		child.initialize(base_node_in, black_board)
	change_state(starting_state)
	is_active = true

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	#print("Entered state %s" % current_state)
	current_state.enter()

func _physics_process(delta: float) -> void:
	if !is_active:
		return
	try_change_state(current_state.process_physics(delta))

func _unhandled_input(event: InputEvent) -> void:
	if !is_active:
		return
	try_change_state(current_state.process_input(event))

func _process(delta: float) -> void:
	if !is_active:
		return
	try_change_state(current_state.process_frame(delta))

func try_change_state(state: State) -> void:
	if state:
		change_state(state)
