extends ItemList


func _ready() -> void:
	clear()
	var i: int = 0
	for level: LevelTemplate in ResourceDataHandler.resource_dict["levels"]:
		add_item(level.level_name)
		set_item_metadata(i, level)
		i += 1


func _on_item_selected(index: int) -> void:
	var level: LevelTemplate = get_item_metadata(index)
	ServiceLocator.game_manager.load_level(level)
