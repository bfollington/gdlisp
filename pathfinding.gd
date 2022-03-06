extends Node2D

onready var navigation: Navigation2D = $Navigation2D
onready var line: Line2D = $Line2D
onready var character: Sprite = $Character
onready var tiles: TileMap = $Navigation2D/TileMap
onready var _half_cell_size: Vector2 = tiles.cell_size / 2


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event: InputEvent):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
		
	var path = find_path(character.global_position, get_global_mouse_position())
	line.points = path
	character.path = path
	pass
	
func find_path(from: Vector2, to: Vector2) -> PoolVector2Array:
	var simple_path = navigation.get_simple_path(from, _convert_to_tile_center(to), false)
	var path = PoolVector2Array([])
	var simple_path_max_index = simple_path.size() - 1

	for step_index in range(simple_path_max_index + 1):
		var current_step = simple_path[step_index]
		path.append(_convert_to_tile_center(current_step))

		if step_index < simple_path_max_index:
			var next_step = simple_path[step_index + 1]
			var middle_step = _find_middle_point_if_needed(current_step, next_step)
			if middle_step != null: path.append(_convert_to_tile_center(middle_step))

	return path
	
func _find_middle_point_if_needed(start: Vector2, end: Vector2):
	var start_map_position = tiles.world_to_map(start)
	var end_map_position = tiles.world_to_map(end)
	var diff: Vector2 = start_map_position - end_map_position

	if diff.x != 0 and diff.y != 0:
		return _find_middle_point(start_map_position, end_map_position)

	return null

func _find_middle_point(start: Vector2, end: Vector2) -> Vector2:
	var middle_point = Vector2(start.x, start.y)
	var direction_vector: Vector2 = start.direction_to(end)

	if direction_vector.x < 0 and direction_vector.y > 0:
		middle_point.x = start.x  - 1

	if direction_vector.y < 0:
		middle_point.y = start.y - 1

	if direction_vector.x > 0 and direction_vector.y > 0:
		middle_point.x = start.x + 1
#
	return tiles.map_to_world(middle_point)


func _convert_to_tile_center(tile_world_position: Vector2) -> Vector2:
	return tiles.map_to_world(tiles.world_to_map(tile_world_position)) + _half_cell_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
