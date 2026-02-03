require 'pry'
class Player
  attr_accessor :name, :life_points
  def initialize(name)
    @name = name
    @life_points = 10
  end
  def show_state()
    if @life_points > 0
      puts "Player #{@name} has #{@life_points} HP left."
    end
  end
  def gets_damage(damage_taken)
    @life_points = @life_points - damage_taken
    if @life_points > 0 
      puts "Player #{@name} has taken #{damage_taken} damage !"
    end
    if @life_points <= 0
      puts "Player #{@name} has been slayed !"
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

class HumanPlayer < Player
  attr_accessor :name, :life_points, :weapon_level
  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end
  def show_state()
    if @life_points > 0
      puts "Player #{@name} has #{@life_points} HP remaining."
      puts "Weapon level : #{@weapon_level}"
    end
  end
  def compute_damage()
    return rand(1..6) * @weapon_level
  end
  def search_weapon()
    found_weapon_lvl = rand(1..6)
    puts "You have found a level #{found_weapon_lvl} weapon."
    if found_weapon_lvl > @weapon_level
      puts "+#{found_weapon_lvl - @weapon_level}lvl weapon upgrade"
      @weapon_level = found_weapon_lvl
      puts "Great ! A better one. You keep it !"
    else 
      puts "No luck, its a shitty weapon"
    end
  end
  def search_health_pack()
    found_health_pack = rand(1..6)
    if found_health_pack == 1
      puts "Nothing..."
    elsif found_health_pack >= 2 && found_health_pack <= 5
      @life_points = @life_points + 50
      if @life_points > 100
        @life_points = 100
      end
      puts "You have found one +50 health pack !"
    else
      @life_points = @life_points + 80
      if @life_points > 100
        @life_points = 100
      end
      puts "You have found one +80 health pack ! Sweet."
    end
  end
end