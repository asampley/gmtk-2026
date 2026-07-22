extends Node


const timeout_s: float = 3.0
const ANALYTICS_CONFIG_SAVE_PATH: String = "user://analytics.cfg"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !(get_tree().root.has_node("Talo")):
		EventBus.setup_events.player_identified.emit()
		return
	if await Talo.is_offline():
		EventBus.setup_events.player_identified.emit()
		return
	var unique_id: String = load_analytics_id()
	if unique_id == "":
		unique_id = generate_analytics_id()
	await Talo.players.identify("anonymous", unique_id)
		
	EventBus.setup_events.player_identified.emit()

func generate_analytics_id() -> String:
	var new_id :=Talo.players.generate_identifier()
	var config := ConfigFile.new()
	config.set_value("identity", "id", new_id)
	config.save(ANALYTICS_CONFIG_SAVE_PATH)
	return new_id

func load_analytics_id() -> String:
	var config := ConfigFile.new()
	if config.load(ANALYTICS_CONFIG_SAVE_PATH) == OK:
		return config.get_value("identity", "id", "")
	return ""
