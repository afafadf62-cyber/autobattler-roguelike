extends Node

# Game Configuration
const TILE_SIZE = 32
const GRID_WIDTH = 16
const GRID_HEIGHT = 10
const WAVES_PER_RUN = 5

# Unit Stats
const UNIT_SPEED = 50.0  # pixels per second
const UNIT_BASE_HEALTH = 10
const UNIT_BASE_DAMAGE = 1

# Building Configuration
const BUILDING_PRODUCTION_INTERVAL = 3.0  # seconds
const BUILDING_UNIT_COST = 1  # gold to produce a unit
const STARTING_GOLD = 50

# Unit Types
enum UnitType {
	WARRIOR,    # Melee, balanced
	ARCHER,     # Ranged, lower health
	MAGE,       # Ranged, low health, high damage
	TANK        # Melee, high health, low damage
}

# Building Types
enum BuildingType {
	BARRACKS,      # Produces warriors
	ARCHER_TOWER,  # Produces archers
	MAGE_TOWER,    # Produces mages
	GOLD_MINE      # Produces gold
}

# Unit Type Stats (health, damage, speed, attack_range, production_cost)
const UNIT_STATS = {
	UnitType.WARRIOR: {"health": 15, "damage": 2, "speed": 50, "range": 10, "cost": 5},
	UnitType.ARCHER: {"health": 8, "damage": 3, "speed": 60, "range": 60, "cost": 5},
	UnitType.MAGE: {"health": 6, "damage": 4, "speed": 40, "range": 80, "cost": 7},
	UnitType.TANK: {"health": 25, "damage": 1, "speed": 30, "range": 10, "cost": 8}
}

# Building Stats (production_rate, gold_per_tick)
const BUILDING_STATS = {
	BuildingType.BARRACKS: {"unit_type": UnitType.WARRIOR, "production_rate": 2.0},
	BuildingType.ARCHER_TOWER: {"unit_type": UnitType.ARCHER, "production_rate": 2.5},
	BuildingType.MAGE_TOWER: {"unit_type": UnitType.MAGE, "production_rate": 3.0},
	BuildingType.GOLD_MINE: {"gold_per_tick": 3, "production_rate": 1.0}
}
