extends Node


const SAVE_PATH = "user://save_game.json"
var data_dictionary: Dictionary[String, Variant] = {}

func _ready() -> void:
	if check_save_file_exists():
		var error := load_data()
		if error != OK:
			push_error("Error loading data: " + str(error))

func save_data(data_key: String, data_value: Variant) -> Error:
	data_dictionary[data_key] = data_value
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data_dictionary))
	file.close()
	return OK

func load_data() -> Error:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return FileAccess.get_open_error()

	var json := JSON.new()
	var error := json.parse(file.get_as_text())
	if error != OK:
		return error

	var data: Variant = json.data
	if typeof(data) == TYPE_DICTIONARY:
		data_dictionary.assign(data)
	else:
		return Error.ERR_INVALID_DATA

	return OK

func reset_save_data() -> void:
	DirAccess.remove_absolute(SAVE_PATH)

func check_save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
