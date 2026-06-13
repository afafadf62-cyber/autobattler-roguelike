extends Node
## BuildingManager - Manages building placement and production

var buildings: Array = []
var grid_manager: Node2D = null

func _ready() -> void:
	grid_manager = get_node("../GridManager")

## Place a building at grid position
func place_building(grid_pos: Vector2i, building_type: Constants.BuildingType, team: int = 0) -> bool:
	if not grid_manager.is_valid_position(grid_pos) or grid_manager.is_occupied(grid_pos):
		return false
	
	var new_building = preload("res://scenes/building.tscn").instantiate()
	new_building.building_type = building_type
	new_building.team = team
	
	if grid_manager.place_building(grid_pos, new_building):
		add_child(new_building)
		buildings.append(new_building)
		new_building.add_to_group("buildings")
		return true
	
	return false

## Get all buildings
func get_all_buildings() -> Array:
	return buildings.filter(func(b): return is_instance_valid(b))

## Get buildings by team
func get_buildings_by_team(team: int) -> Array:
	return buildings.filter(func(b): return is_instance_valid(b) and b.team == team)

## Remove a building
func remove_building(building: Node2D) -> void:
	if building in buildings:
		buildings.erase(building)
		building.queue_free()
