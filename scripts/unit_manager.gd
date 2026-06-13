extends Node
## UnitManager - Manages all units on the battlefield

var units: Array = []

func _ready() -> void:
	# Units will be added dynamically via add_child()
	pass

func _process(delta: float) -> void:
	# Clean up dead units
	units = units.filter(func(u): return is_instance_valid(u) and u.is_alive)

## Add a unit to tracking
func add_unit(unit: Node2D) -> void:
	if unit not in units:
		units.append(unit)

## Get all units
func get_all_units() -> Array:
	return units.filter(func(u): return is_instance_valid(u))

## Get units by team
func get_units_by_team(team: int) -> Array:
	return units.filter(func(u): return is_instance_valid(u) and u.team == team)

## Get alive units by team
func get_alive_units_by_team(team: int) -> Array:
	return units.filter(func(u): return is_instance_valid(u) and u.team == team and u.is_alive)

## Count units by team
func count_units_by_team(team: int) -> int:
	return get_alive_units_by_team(team).size()
