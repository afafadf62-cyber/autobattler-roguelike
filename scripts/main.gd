extends Node2D
## Main.gd - Main scene that orchestrates all game systems

@onready var grid_manager = $GridManager
@onready var unit_manager = $UnitManager
@onready var building_manager = $BuildingManager
@onready var game_manager = $GameManager
@onready var hud = $HUD

func _ready() -> void:
	# Set up initial player buildings
	setup_player_base()
	
	# Connect signals
	game_manager.gold_changed.connect(_on_gold_changed)
	game_manager.wave_started.connect(_on_wave_started)
	game_manager.wave_completed.connect(_on_wave_completed)

func setup_player_base() -> void:
	# Place starting buildings for player
	building_manager.place_building(Vector2i(2, 4), Constants.BuildingType.BARRACKS, 0)
	building_manager.place_building(Vector2i(3, 4), Constants.BuildingType.ARCHER_TOWER, 0)
	building_manager.place_building(Vector2i(4, 4), Constants.BuildingType.GOLD_MINE, 0)

func _on_gold_changed(new_gold: int) -> void:
	hud.update_gold_display(new_gold)

func _on_wave_started(wave_number: int) -> void:
	hud.show_wave_message("Wave %d" % wave_number)

func _on_wave_completed() -> void:
	hud.show_wave_message("Wave Complete!")

func _input(event: InputEvent) -> void:
	# Handle building placement on mouse click
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_local_mouse_position()
		var grid_pos = grid_manager.world_to_grid(mouse_pos)
		
		# Simple placement: try to place barracks
		if Input.is_action_pressed("ui_shift"):
			building_manager.place_building(grid_pos, Constants.BuildingType.BARRACKS, 0)
