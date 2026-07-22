class_name BehaviourManager
extends ControlManager


@export var body: Node2D
@export var state_machine: StateMachine


func _initialize() -> void:
	super()
	state_machine.initialize(self)

func set_movement(should_move: bool, pos: Vector2) -> void:
	movement_set.emit(should_move, pos)

func set_rotation(rot: float) -> void:
	rotation_set.emit(rot)

func use_action(should_use: bool) -> void:
	action_pressed.emit(0, should_use)
	action_pressed.emit(1, should_use)

func set_shield(set_active: bool) -> void:
	shield_used.emit(set_active, false)
