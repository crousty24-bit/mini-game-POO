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
end