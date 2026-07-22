class_name Animatable


var control: Control
var ui_animation_data: UIAnimationData
var default_properties: Dictionary = {}


func initialize(control_in: Control, ui_animation_data_in: UIAnimationData) -> void:
	control = control_in
	ui_animation_data = ui_animation_data_in
	default_properties["position"] = control.position
	default_properties["scale"] = control.scale
	default_properties["rotation"] = control.rotation
	default_properties["modulate"] = control.modulate
	for animation: UIAnimation in ui_animation_data.animations:
		animation.default_properties = default_properties

func on_trigger(activate: bool) -> void:
	if activate:
		on_activate()
	else:
		on_deactivate()

func on_activate() -> void:
	if !ui_animation_data:
		return
	if ui_animation_data.is_parallel:
		for animation: UIAnimation in ui_animation_data.animations:
			animation._activate_animation(control)
	else:
		for animation: UIAnimation in ui_animation_data.animations:
			animation._activate_animation(control)
			await animation.completed

func on_deactivate() -> void:
	if !ui_animation_data:
		return
	if ui_animation_data.is_parallel:
		for animation: UIAnimation in ui_animation_data.animations:
			animation._deactivate_animation(control)
	else:
		for animation: UIAnimation in ui_animation_data.animations:
			animation._deactivate_animation(control)
			await animation.completed

func clear_all_animation_tweens() -> void:
	if !ui_animation_data:
		return
	for animation: UIAnimation in ui_animation_data.animations:
		animation.clear_tweens()
