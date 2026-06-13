extends Node
## GameManager - Handles core game loop, roguelike progression, and wave system

signal wave_started(wave_number: int)
signal wave_completed
signal run_completed
signal gold_changed(new_gold: int)
signal relics_offered(relics: Array)

var current_wave: int = 0
var current_gold: int = 0
var player_base_position: Vector2 = Vector2(100, 100)
var enemy_base_position: Vector2 = Vector2(700, 300)
var grid_manager: Node2D = null
var unit_manager: Node = null
var building_manager: Node = null

var active_relics: Array = []
var wave_in_progress: bool = false

func _ready() -> void:
	current_gold = Constants.STARTING_GOLD
	gold_changed.emit(current_gold)
	
	# Get references to managers
	grid_manager = get_node("GridManager")
	unit_manager = get_node("UnitManager")
	building_manager = get_node("BuildingManager")
	
	start_wave()

func _process(delta: float) -> void:
	if wave_in_progress:
		check_wave_completion()
		collect_building_gold()

## Start a new wave
func start_wave() -> void:
	current_wave += 1
	wave_in_progress = true
	wave_started.emit(current_wave)
	
	# Spawn enemy units/buildings based on wave number
	spawn_enemy_wave()

## Check if current wave is complete
func check_wave_completion() -> void:
	# Wave is complete when all enemy units are dead
	var enemy_units = get_tree().get_nodes_in_group("units")
	var has_enemies = false
	
	for unit in enemy_units:
		if unit.team == 1 and unit.is_alive:  # team 1 = enemies
			has_enemies = true
			break
	
	if not has_enemies:
		complete_wave()

## Complete current wave
func complete_wave() -> void:
	wave_in_progress = false
	wave_completed.emit()
	
	if current_wave >= Constants.WAVES_PER_RUN:
		complete_run()
	else:
		# Offer relics before next wave
		await get_tree().create_timer(1.0).timeout
		offer_relics()

## Spawn enemies for current wave
func spawn_enemy_wave() -> void:
	# Simple scaling: more units each wave
	var unit_count = 2 + current_wave
	
	for i in range(unit_count):
		var new_unit = preload("res://scenes/unit.tscn").instantiate()
		new_unit.unit_type = Constants.UnitType.WARRIOR
		new_unit.team = 1  # Enemy team
		new_unit.global_position = enemy_base_position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		
		unit_manager.add_child(new_unit)
		new_unit.add_to_group("units")

## Collect gold from buildings
func collect_building_gold() -> void:
	var buildings = get_tree().get_nodes_in_group("buildings")
	var collected_gold = 0
	
	for building in buildings:
		if building.team == 0:  # Player buildings
			collected_gold += building.get_gold()
	
	if collected_gold > 0:
		add_gold(collected_gold)

## Add gold to player
func add_gold(amount: int) -> void:
	current_gold += amount
	gold_changed.emit(current_gold)

## Spend gold (returns true if successful)
func spend_gold(amount: int) -> bool:
	if current_gold >= amount:
		current_gold -= amount
		gold_changed.emit(current_gold)
		return true
	return false

## Offer relics for selection
func offer_relics() -> void:
	var available_relics = get_random_relics(3)
	relics_offered.emit(available_relics)

## Get random relics (placeholder)
func get_random_relics(count: int) -> Array:
	var relics = []
	# TODO: Implement relic system
	return relics

## Complete the run
func complete_run() -> void:
	run_completed.emit()
	print("Run completed! Final gold: ", current_gold)
