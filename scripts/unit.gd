extends CharacterBody2D
## Unit - Base class for all units in the game

@export var unit_type: Constants.UnitType = Constants.UnitType.WARRIOR
@export var team: int = 0  # 0 = player, 1 = enemy

var max_health: int
var current_health: int
var damage: int
var speed: float
var attack_range: float
var target: Node2D = null
var is_alive: bool = true

func _ready() -> void:
	# Load stats from constants
	var stats = Constants.UNIT_STATS[unit_type]
	max_health = stats["health"]
	current_health = max_health
	damage = stats["damage"]
	speed = stats["speed"]
	attack_range = stats["range"]
	
	# Setup visuals
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = 8

func _process(delta: float) -> void:
	if not is_alive:
		return
	
	# Find target if none
	if target == null or not is_instance_valid(target):
		find_target()
	
	# Move toward target
	if target != null:
		move_toward_target(delta)
		check_attack()

## Find nearest enemy unit
func find_target() -> void:
	var units = get_tree().get_nodes_in_group("units")
	var nearest_distance = INF
	var nearest_unit = null
	
	for unit in units:
		if unit == self or unit.team == team or not unit.is_alive:
			continue
		
		var distance = global_position.distance_to(unit.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_unit = unit
	
	target = nearest_unit

## Move toward target
func move_toward_target(delta: float) -> void:
	if target == null:
		velocity = velocity.lerp(Vector2.ZERO, 0.1)
	else:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
	
	move_and_slide()

## Check if we can attack target
func check_attack() -> void:
	if target == null or not is_instance_valid(target):
		return
	
	var distance = global_position.distance_to(target.global_position)
	if distance <= attack_range:
		attack(target)

## Attack a target
func attack(target: Node2D) -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage)

## Take damage
func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

## Die
func die() -> void:
	is_alive = false
	queue_free()

## Get health percentage (for UI)
func get_health_percentage() -> float:
	return float(current_health) / float(max_health)
