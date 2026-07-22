extends Node


var resource_dict: Dictionary[String, Array] = {}
const resource_superfolder_path := "res://game/_templates/"


func _ready() -> void:
	for folder: String in DirAccess.get_directories_at(resource_superfolder_path):
		var full_path := resource_superfolder_path + folder + "/"
		var resource_strings := get_resource_paths(full_path)
		var resource_array: Array[Resource] = []
		for resource_path: String in resource_strings:
			resource_array.append(ResourceLoader.load(resource_path))
		resource_dict[folder] = resource_array

func get_resource_paths(path: String) -> PackedStringArray:
	var paths: PackedStringArray = []
	for resource_name: String in DirAccess.get_files_at(path):
		if OS.has_feature("web"):
			resource_name = resource_name.trim_suffix(".remap")
		paths.append(path + resource_name)
	return paths
