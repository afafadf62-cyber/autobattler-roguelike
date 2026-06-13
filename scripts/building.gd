extends Node2D
## Building - Base class for all buildings in the game

@export var building_type: Constants.BuildingType = Constants.BuildingType.BARRACKS
@export var team: int = 0  # 0 = player, 1 = enemy

var production_timer: float = 0.0
var gold_accumulated: int = 0
var unit_manager: Node = null

func _ready() -> void:
	add_to_group("buildings")
	# Setup visuals - simple square for now
	var sprite = Sprite2D.new()
	sprite.modulate = Color.BLUE if team == 0 else Color.RED
	add_child(sprite)
	
	# Get reference to unit manager
	unit_manager = get_tree().root.get_node("Main/UnitManager")

func _process(delta: float) -> void:
	production_timer += delta
	
	# Check if it's time to produce
	var stats = Constants.BUILDING_STATS[building_type]
	if production_timer >= stats["production_rate"]:
		production_timer = 0.0
		produce()

## Produce units or gold based on building type
func produce() -> void:
	var stats = Constants.BUILDING_STATS[building_type]
	
	if building_type == Constants.BuildingType.GOLD_MINE:
		# Produce gold
		gold_accumulated += stats["gold_per_tick"]
	else:
		# Produce unit
		var unit_type = stats["unit_type"]
		spawn_unit(unit_type)

## Spawn a unit from this building
func spawn_unit(unit_type: Constants.UnitType) -> void:
	if unit_manager == null:
		return
	
	var new_unit = preload("res://scenes/unit.tscn").instantiate()
	new_unit.unit_type = unit_type
	new_unit.team = team
	new_unit.global_position = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
	
	unit_manager.add_child(new_unit)
	new_unit.add_to_group("units")

## Get accumulated gold
func get_gold() -> int:
	var gold = gold_accumulated
	gold_accumulated = 0
	return gold
