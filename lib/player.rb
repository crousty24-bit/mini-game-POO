require 'pry'
class Player
  attr_accessor :name, :life_points
  def initialize(name)
    @name = name
    @life_points = 10
  end
  def show_state()
    puts "Player #{@name} has #{@life_points} HP left"
  end
  def gets_damage(damage_taken)
    @life_points = @life_points - damage_taken
    if @life_points > 0 
      puts "Player #{@name} has taken #{damage_taken} damage !"
    end
    if @life_points <= 0
      puts "Player #{@name} has been slayed by ennemy !"
    end
  end
  def attacks(player)
    puts "Player #{@name} attacks player #{player.name} !"
    damage_points = compute_damage()
    if damage_points == 6
      damage_points = damage_points + 2
      puts "It scores a Crit(+2 dmg) ! Attack inflict #{damage_points} damage !"
      player.gets_damage(damage_points)
    else
      puts "Attack inflict #{damage_points} damage."
      player.gets_damage(damage_points)
    end
  end
  def compute_damage()
    return rand(1..6)
  end
end