class_name Level
extends Node


@onready var tools: Control = %Tools

var selection_manager := SelectionManager.new()
var enabled_tools: Array[Tool]
var time_elapsed_s: float
var initialized: bool = false


func initialize(enabled_tools_in: Array[ToolTemplate]) -> void:
	time_elapsed_s = 0
	initialize_selection_manager()
	initialize_tools(enabled_tools_in)
	for tool: Tool in enabled_tools:
		tool.pulse()
	initialized = true

func _process(delta: float) -> void:
	if !initialized:
		return
	
	time_elapsed_s += delta
	if time_elapsed_s >= 1:
		for tool: Tool in enabled_tools:
			tool.pulse()
		time_elapsed_s -= 1 


func initialize_selection_manager() -> void:
	add_child(selection_manager)
	var selection_icon := SelectionIcon.new()
	add_child(selection_icon)
	selection_icon.size = Vector2(100,100)
	selection_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	selection_manager.initialize(selection_icon)

func initialize_tools(enabled_tools_in: Array[ToolTemplate]) -> void:
	for tool: Tool in tools.get_children():
		if enabled_tools_in.has(tool.tool_template):
			enabled_tools.append(tool)
			tool.initialize(selection_manager)
		else:
			tool.initialize(null)
