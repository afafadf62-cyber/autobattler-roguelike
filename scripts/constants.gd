extends Node
## Constants - Global game configuration and settings

const GRID_WIDTH: int = 10
const GRID_HEIGHT: int = 8
const TILE_SIZE: int = 64

const STARTING_GOLD: int = 100
const WAVES_PER_RUN: int = 5

enum UnitType {
	WARRIOR,
	ARCHER,
	MAGE,
	PALADIN
}

enum BuildingType {
	BARRACKS,
	ARCHER_TOWER,
	MAGE_TOWER,
	GOLD_MINE,
	WALL
}

var UNIT_STATS = {
	UnitType.WARRIOR: {
		"health": 30,
		"damage": 8,
		"speed": 80.0,
		"range": 20.0
	},
	UnitType.ARCHER: {
		"health": 15,
		"damage": 12,
		"speed": 60.0,
		"range": 150.0
	},
	UnitType.MAGE: {
		"health": 20,
		"damage": 15,
		"speed": 70.0,
		"range": 120.0
	},
	UnitType.PALADIN: {
		"health": 50,
		"damage": 10,
		"speed": 60.0,
		"range": 20.0
	}
}

var BUILDING_STATS = {
	BuildingType.BARRACKS: {
		"production_rate": 3.0,
		"unit_type": UnitType.WARRIOR,
		"gold_per_tick": 0,
		"cost": 50
	},
	BuildingType.ARCHER_TOWER: {
		"production_rate": 4.0,
		"unit_type": UnitType.ARCHER,
		"gold_per_tick": 0,
		"cost": 75
	},
	BuildingType.MAGE_TOWER: {
		"production_rate": 5.0,
		"unit_type": UnitType.MAGE,
		"gold_per_tick": 0,
		"cost": 100
	},
	BuildingType.GOLD_MINE: {
		"production_rate": 2.0,
		"unit_type": UnitType.WARRIOR,
		"gold_per_tick": 10,
		"cost": 60
	},
	BuildingType.WALL: {
		"production_rate": 0.0,
		"unit_type": UnitType.WARRIOR,
		"gold_per_tick": 0,
		"cost": 30
	}
}
