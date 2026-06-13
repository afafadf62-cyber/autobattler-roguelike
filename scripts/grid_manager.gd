extends Node2D
## GridManager - Handles tile-based grid system and building placement

var grid_width: int
var grid_height: int
var tile_size: int
var buildings: Dictionary = {}  # {Vector2i: Building}
var grid_rect: Rect2

func _ready() -> void:
	grid_width = Constants.GRID_WIDTH
	grid_height = Constants.GRID_HEIGHT
	tile_size = Constants.TILE_SIZE
	grid_rect = Rect2(0, 0, grid_width * tile_size, grid_height * tile_size)

## Convert world position to grid coordinates
func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(int(world_pos.x / tile_size), int(world_pos.y / tile_size))

## Convert grid coordinates to world position
func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos.x * tile_size + tile_size / 2, grid_pos.y * tile_size + tile_size / 2)

## Check if grid position is valid
func is_valid_position(grid_pos: Vector2i) -> bool:
	return grid_pos.x >= 0 and grid_pos.x < grid_width and grid_pos.y >= 0 and grid_pos.y < grid_height

## Check if a position is occupied by a building
func is_occupied(grid_pos: Vector2i) -> bool:
	return buildings.has(grid_pos)

## Place a building at grid position
func place_building(grid_pos: Vector2i, building: Node2D) -> bool:
	if not is_valid_position(grid_pos) or is_occupied(grid_pos):
		return false
	
	buildings[grid_pos] = building
	building.position = grid_to_world(grid_pos)
	return true

## Remove a building from the grid
func remove_building(grid_pos: Vector2i) -> void:
	if buildings.has(grid_pos):
		buildings.erase(grid_pos)

## Get building at grid position
func get_building(grid_pos: Vector2i) -> Node2D:
	return buildings.get(grid_pos, null)

## Draw grid for debugging
func _draw() -> void:
	# Draw grid lines
	for x in range(grid_width + 1):
		draw_line(Vector2(x * tile_size, 0), Vector2(x * tile_size, grid_height * tile_size), Color.GRAY, 0.5)
	
	for y in range(grid_height + 1):
		draw_line(Vector2(0, y * tile_size), Vector2(grid_width * tile_size, y * tile_size), Color.GRAY, 0.5)
