class_name PopupUI
extends Control


@onready var label: Label = %Label


func initialize(template: PopupTemplate) -> void:
	label.text = template.text
	global_position = template.screen_pos
