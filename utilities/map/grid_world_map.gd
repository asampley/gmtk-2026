class_name GridWorldMap

## Grid system for when you don't want a tilemap

var grid_size: Vector2i
var grid_pos_world_pos_dict: Dictionary[Vector2i, Vector2] = {}
var world_pos_grid_pos_dict: Dictionary[Vector2, Vector2i] = {}
var edge_tiles: Array[Vector2i]
var x_world_limits: Vector2
var y_world_limits: Vector2


func initialize(grid_size_in: Vector2i, world_tile_size: Vector2) -> void:
	grid_size = grid_size_in
	for x: int in grid_size.x:
		for y: int in grid_size.y:
			var grid_pos := Vector2i(x, y)
			var grid_offset := grid_size / 2
			var world_offset := Vector2(grid_pos - grid_offset) * world_tile_size
			var world_pos: Vector2 = world_offset + world_tile_size / 2
			grid_pos_world_pos_dict[grid_pos] = world_pos
			world_pos_grid_pos_dict[world_pos] = grid_pos
			if x < 3 || y < 3 || grid_size.x - x < 3 || grid_size.y - y < 3:
				edge_tiles.append(grid_pos)
	generate_world_limits()

func generate_world_limits() -> void:
	var minimum := grid_pos_world_pos_dict[Vector2i(0,0)]
	var maximum := grid_pos_world_pos_dict[grid_size - Vector2i(1,1)]
	x_world_limits = Vector2(minimum.x, maximum.x)
	y_world_limits = Vector2(minimum.y, maximum.y)

func grid_pos_to_world_pos(grid_pos: Vector2i) -> Vector2:
	return grid_pos_world_pos_dict[grid_pos]

func world_pos_to_grid_pos(world_pos: Vector2) -> Vector2i:
	return world_pos_grid_pos_dict[world_pos]

func check_in_world_bounds(world_pos: Vector2) -> bool:
	if world_pos.x < x_world_limits.x || world_pos.x > x_world_limits.y:
		return false
	if world_pos.y < y_world_limits.x || world_pos.y > y_world_limits.y:
		return false
	return true

func get_screen_wrap_pos(world_pos: Vector2) -> Vector2:
	if world_pos.x < x_world_limits.x:
		world_pos.x = x_world_limits.y
		return world_pos
	elif world_pos.x > x_world_limits.y:
		world_pos.x = x_world_limits.x
		return world_pos
	elif world_pos.y < y_world_limits.x:
		world_pos.y = y_world_limits.y
		return world_pos
	elif world_pos.y > y_world_limits.y:
		world_pos.y = y_world_limits.x
		return world_pos
	printerr("Screen wrap error.")
	return world_pos

func get_random_world_pos(exclusions: Array[Vector2i] = []) -> Vector2:
	var random_grid_pos: Vector2i
	var generating := true
	
	while generating:
		random_grid_pos = grid_pos_world_pos_dict.keys().pick_random()
		var spot_clear: bool = true
		for pos: Vector2i in exclusions:
			if random_grid_pos == pos:
				spot_clear = false
		if spot_clear:
			generating = false
	return grid_pos_to_world_pos(random_grid_pos)
