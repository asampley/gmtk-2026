class_name Reagent
extends Resource

@export var name: String
@export var icon: Texture2D

@export var decay_templates: Array[DecayTemplate]

func get_decay_template(tool: ToolTemplate) -> DecayTemplate:
	for decay_template: DecayTemplate in decay_templates:
		if decay_template.tool == tool:
			return decay_template
	return null
