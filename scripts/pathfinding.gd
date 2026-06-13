extends Node2D
## Pathfinding.gd - A* pathfinding for unit movement

class_name Pathfinding

var grid_width: int
var grid_height: int
var tile_size: int
var obstacles: Dictionary = {}  # {Vector2i: bool}

func _init(width: int, height: int, size: int) -> void:
	grid_width = width
	grid_height = height
	tile_size = size

## Add an obstacle
func add_obstacle(grid_pos: Vector2i) -> void:
	obstacles[grid_pos] = true

## Remove an obstacle
func remove_obstacle(grid_pos: Vector2i) -> void:
	obstacles.erase(grid_pos)

## Find path using A* algorithm
func find_path(start: Vector2i, end: Vector2i) -> Array:
	var open_set = [start]
	var came_from = {}
	var g_score = {start: 0}
	var f_score = {start: heuristic(start, end)}
	
	while open_set.size() > 0:
		# Find node with lowest f_score
		var current = open_set[0]
		var current_idx = 0
		
		for i in range(open_set.size()):
			if f_score.get(open_set[i], INF) < f_score.get(current, INF):
				current = open_set[i]
				current_idx = i
		
		if current == end:
			return reconstruct_path(came_from, current)
		
		open_set.remove_at(current_idx)
		
		# Check neighbors
		for neighbor in get_neighbors(current):
			var tentative_g_score = g_score[current] + 1
			
			if tentative_g_score < g_score.get(neighbor, INF):
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				f_score[neighbor] = tentative_g_score + heuristic(neighbor, end)
				
				if neighbor not in open_set:
					open_set.append(neighbor)
	
	return []  # No path found

## Heuristic function (Manhattan distance)
func heuristic(pos: Vector2i, goal: Vector2i) -> int:
	return abs(pos.x - goal.x) + abs(pos.y - goal.y)

## Get valid neighbors
func get_neighbors(pos: Vector2i) -> Array:
	var neighbors = []
	var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	
	for dir in directions:
		var neighbor = pos + dir
		if is_valid(neighbor) and not obstacles.has(neighbor):
			neighbors.append(neighbor)
	
	return neighbors

## Check if position is valid
func is_valid(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < grid_width and pos.y >= 0 and pos.y < grid_height

## Reconstruct path from came_from dictionary
func reconstruct_path(came_from: Dictionary, current: Vector2i) -> Array:
	var path = [current]
	
	while came_from.has(current):
		current = came_from[current]
		path.insert(0, current)
	
	return path
