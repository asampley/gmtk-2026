class_name SelectionManager

var selection_icon: SelectionIcon

var current_selection: Tool:
	set(tool):
		current_selection = tool
		if current_selection:
			selection_icon.set_icon(current_selection.removable_reagent.icon)
		else:
			selection_icon.set_icon(null)

func initialize(selection_icon_in: SelectionIcon) -> void:
	selection_icon = selection_icon_in

func select(selection: Tool) -> void:
	if current_selection:
		if current_selection == selection:
			return
		var reagent := current_selection.removable_reagent
		if reagent && selection.can_take_reagent(reagent):
			current_selection.remove_reagent(reagent)
			selection.add_reagent(reagent)
			current_selection = null
	else:
		if selection.removable_reagent:
			current_selection = selection
			print(current_selection.removable_reagent.name)
