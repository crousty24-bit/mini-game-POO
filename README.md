# Mini Game POO

A turn-based combat game written in Ruby demonstrating Object-Oriented Programming principles with inheritance, encapsulation, and polymorphism.

## Description

Mini Game POO is a text-based arena battle simulator with multiple game versions showcasing different complexity levels of game design. The full v3.0 implementation features:

- **Dynamic Enemy System**: Enemies spawn randomly during gameplay with 10 different NPC names
- **Interactive Menu**: Player-driven combat with weapon/health search options
- **Progressive Difficulty**: All enemies must be defeated to win (10 total enemies to clear)
- **Multiple Game Modes**: 3 versions from simple 1v1 duel to full arena battles

## Requirements

- Ruby 3.4.2 or higher
- Bundler (for dependency management)

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd mini-game-POO
```

2. Install dependencies:
```bash
bundle install
```

## Usage

Run v1.0 (basic game with two fixed players):
```bash
ruby app.rb
```

Run v2.0 (player vs two fixed enemies):
```bash
ruby app_2.rb
```

Run v3.0 (full arena battle with dynamic enemies and menu system):
```bash
ruby app_3.rb
```

## Project Structure

```
mini-game-POO/
├── app.rb              # Main game entry point (v1.0 - simple duel)
├── app_2.rb            # Alternative game version (v2.0 - vs two fixed enemies)
├── app_3.rb            # Arena battle version (v3.0 - dynamic enemies with menu)
├── Gemfile             # Ruby dependencies
├── lib/
│   ├── game.rb         # Game logic (v3.0 - arena battle system)
│   └── player.rb       # Player classes and combat mechanics
└── spec/
    └── spec_helper.rb  # Test configuration
```

## Game Mechanics

### v1.0: Simple Duel
- Two fixed players battle until one dies
- Basic turn-based combat system

### v2.0: Player vs Two Enemies
- Human player with special mechanics battles two fixed enemy players
- Menu-driven player actions (search weapon, search health pack, attack)

### v3.0: Arena Battle System
- Player enters an arena and fights against multiple dynamic enemies
- Enemies spawn randomly (0-2 per turn) from a pool of 10 opponents
- Interactive menu system with weapon/health search and target selection
- Game continues until either the player dies or all enemies are defeated

### Combat System
- Players alternate turns attacking each other
- Damage is calculated randomly between 1-6 (or 1-6 * weapon_level for Human players)
- Critical hits occur on a roll of 6, adding 2 bonus damage
- Game ends when one player's health reaches 0 or below

### Human Player Features
- **Weapon System**: Discover weapons with random levels (1-6) and automatically upgrade if superior
- **Health Recovery**: Find health packs that restore 50 or 80 HP (maximum 100 HP)
- **Enhanced Damage**: Weapon level multiplies base damage output

### Standard Player
- Basic combat mechanics
- Fixed 10 HP
- Standard damage calculation

## Dependencies

- **pry**: Interactive debugging and REPL
- **rspec**: Testing framework
- **rubocop**: Code style and quality analysis

## Development

To run tests:
```bash
bundle exec rspec
```

To check code style:
```bash
bundle exec rubocop
```

To debug interactively, the game automatically opens a Pry session at the end of execution.

## Architecture

The project follows Object-Oriented Programming principles:

- **Inheritance**: `HumanPlayer` extends the `Player` base class
- **Encapsulation**: Private state (life_points, weapon_level) with accessor methods
- **Polymorphism**: Method overriding for `compute_damage()` and `show_state()`
- **Modularity**: Player classes separated in `lib/player.rb`
- **Game Logic**: Arena battle system encapsulated in `Game` class with enemy management and turn-based control

### Game Class (v3.0)
The `Game` class manages:
- Human player creation and state
- Enemy spawning and management (`enemies_in_sight` array)
- Turn-based game loop control (`is_still_ongoing?`)
- Player action menu and processing
- Enemy turn management
- Game end state determination

## Future Enhancements

- Add more enemy types with special abilities
- Implement difficulty levels
- Add persistent player statistics and leaderboards
- Create power-up system beyond weapons and health
- Implement special moves or ultimate abilities
- Add visual improvements and animations

## License

This project is part of The Hacking Project curriculum.

## Author

Created as an exercise for The Hacking Project bootcamp.