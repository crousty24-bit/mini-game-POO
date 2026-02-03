# Mini Game POO

A turn-based combat game written in Ruby demonstrating Object-Oriented Programming principles with inheritance, encapsulation, and polymorphism.

## Description

Mini Game POO is a text-based arena battle simulator where players face off in combat. The game implements different player types with distinct characteristics:

- **Standard Player**: Basic 10 HP with standard 1-6 damage per attack
- **Human Player**: 100 HP with weapon progression, health pack discovery, and enhanced damage scaling

Players take turns attacking each other with random damage values. Human players have access to special mechanics like weapon upgrades and health recovery items.

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

Run the basic game version:
```bash
ruby app.rb
```

Run the alternative game version:
```bash
ruby app_2.rb
```

## Project Structure

```
mini-game-POO/
├── app.rb              # Main game entry point (v1.0)
├── app_2.rb            # Alternative game version
├── Gemfile             # Ruby dependencies
├── lib/
│   ├── game.rb         # Game logic (empty - ready for expansion)
│   └── player.rb       # Player classes and combat mechanics
└── spec/
    └── spec_helper.rb  # Test configuration
```

## Game Mechanics

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

## Future Enhancements

- Implement expanded v3.0 game logic in `lib/game.rb`
- More enemies per game
- Add additional player types and abilities
- Implement special moves or power-ups
- Create difficulty levels
- Add persistent player statistics

## License

This project is part of The Hacking Project curriculum.

## Author

Created as an exercise for The Hacking Project bootcamp.