class_name SelectionManager


var current_selection: Tool


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
