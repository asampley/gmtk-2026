class_name Level
extends Node


@onready var tools: Control = %Tools
@onready var task_manager: TaskManager = %TaskManager
@onready var basket: Tool = %Basket



var selection_manager := SelectionManager.new()
var enabled_tools: Array[Tool]

var initialized: bool = false


func initialize(template: LevelTemplate) -> void:
	task_manager.initialize(template.tasks)
	initialize_selection_manager()
	initialize_tools(template.enabled_devices)
	for tool: Tool in enabled_tools:
		tool.on_pulse(0)
	PulseTimer.pulse.connect(on_pulse)
	PulseTimer.tick.connect(on_tick)
	basket.reagent_whitelist = template.basket_whitelist
	if template.tutorial:
		var tutorial := template.tutorial.instantiate()
		add_child(tutorial)

func initialize_selection_manager() -> void:
	add_child(selection_manager)
	var selection_icon := SelectionIcon.new()
	add_child(selection_icon)
	selection_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	selection_manager.initialize(selection_icon)

func initialize_tools(enabled_tools_in: Array[ToolTemplate]) -> void:
	for tool: Tool in tools.get_children():
		if enabled_tools_in.has(tool.tool_template):
			enabled_tools.append(tool)
			tool.initialize(selection_manager)
		else:
			tool.initialize(null)

func on_tick(pulse: int, tick: int, per_pulse: int) -> void:
	for tool in enabled_tools:
		tool.on_tick(pulse, tick, per_pulse)

func on_pulse(pulse: int) -> void:
	for tool in enabled_tools:
		tool.on_pulse(pulse)
