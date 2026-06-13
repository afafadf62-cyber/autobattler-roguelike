# AutoBattler Roguelike

A 2D top-down auto-battler strategy game with roguelike elements and tile-based base building, inspired by "There Are No Orcs".

## Features

- **Grid/Tile-Based Map**: Place buildings on a tactical grid
- **Automatic Unit Production**: Buildings produce units and resources (gold)
- **Auto-Battle System**: Units automatically march toward enemy base and engage in combat
- **Roguelike Progression**: Run-based structure with relics and upgrades between rounds
- **Multiple Unit Types**: Different units with unique stats and abilities
- **Pickups**: Find and collect power-ups during runs

## Project Structure

```
scenes/
  main.tscn              # Main game scene
  game/
    game_manager.gd      # Core game loop and roguelike progression
    grid_manager.gd      # Tile-based grid system
  units/
    unit.gd              # Base unit script
    unit_manager.gd      # Manages all units on the battlefield
  buildings/
    building.gd          # Base building script
    building_manager.gd  # Manages building placement and production
  ui/
    hud.gd               # Main UI/HUD
    relic_picker.gd      # Relic selection screen

scripts/
  constants.gd           # Game constants and configurations
  pathfinding.gd         # A* pathfinding for unit movement
```

## Getting Started

1. Install [Godot Engine 4.2+](https://godotengine.org/download)
2. Clone this repository
3. Open the project in Godot
4. Run the game (F5)

## Development

This is a beginner-friendly project structure. Start by:
1. Reviewing `GameManager` to understand the roguelike loop
2. Check `GridManager` for tile-based positioning
3. Look at `Unit` and `Building` base classes for game objects
4. Implement specific unit types (Warrior, Archer, Mage, etc.)

## Next Steps

- [ ] Implement tile-based grid rendering
- [ ] Create base unit and building classes
- [ ] Build unit AI and pathfinding
- [ ] Implement auto-battle system
- [ ] Create roguelike progression system
- [ ] Add relic/upgrade system
- [ ] Design UI and menus
