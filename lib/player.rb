require 'pry'
class Player
  attr_accessor :name, :life_points, :armor_points, :weapon_level
  def initialize(name)
    @name = name
    @life_points = 10
    @max_life_points = 10
    possible_armor_values = [0, 5, 10, 20]
    @armor_points = possible_armor_values.sample #random armor value for bots
    @max_armor_points = 20
    possible_weapon_levels = [1, 2, 3, 4]
    @weapon_level = possible_weapon_levels.sample
    @max_weapon_level = 4
  end

# Player Bot Stats #
# -----------------#
  def show_state()
    if @life_points > 0
      puts "Player #{@name} | HP: #{@life_points}/#{@max_life_points} | Armor: #{@armor_points}/#{@max_armor_points} | Weapon LvL: #{@weapon_level}/#{@max_weapon_level}."
    end
  end

# Player Attack Pipline Sequence #
# -------------------------------#
  def attacks(player)
    puts "Player #{@name} attacks player #{player.name} !"
    damage = compute_damage
    puts "Attack inflicts #{damage} damage."
    player.take_hit(damage)
  end

  def compute_damage
    roll = rand(1..6)
    damage = roll * @weapon_level
    if damage >= 18 #crit damage
      damage *= 2
    end
    return damage
  end

  def gets_damage(final_damage)
    @life_points -= final_damage
  end

  def take_hit(damage_received)
    if damage_received < 0 #clamp to prevent negative value
      damage_received = 0
    end
    absorbed = [damage_received, @armor_points].min
    @armor_points -= absorbed #calculate new armor value after absorbtion
    if @armor_points < 0 #clamp to prevent negative value
      @armor_points = 0
    end
    remaining_damage = damage_received - absorbed #get real remaining damage after modifiers
    gets_damage(remaining_damage)
    if @life_points > 0 
      puts "Player #{@name} has taken #{remaining_damage} damage !"
      puts "Absorbed #{absorbed} by armor. Now Armor: #{@armor_points}."
    elsif @life_points <= 0
      puts "Player #{@name} has been slayed !"
    end
  end
end

class HumanPlayer < Player
  attr_accessor :name, :life_points, :weapon_level, :shield_level
  def initialize(name)
    super(name)
    @life_points = 100
    @max_life_points = 100
    @weapon_level = 1
    @max_weapon_level = 10
    @armor_points = 5
    @max_armor_points = 45
    @shield_level = 1
    @max_shield_level = 5
  end

  def show_state()
    if @life_points > 0
      puts "Player #{@name} | HP: #{@life_points}/#{@max_life_points}."
      puts "Weapon LvL: #{@weapon_level}/#{@max_weapon_level}."
      puts "Armor: #{@armor_points}/#{@max_armor_points}."
      puts "Shield LvL: #{@shield_level}/#{@max_shield_level}."
    end
  end

# HumanPlayer Attack Pipline Sequence #
# Add first Defensive stat block-shield #
# -------------------------------#
  def take_hit(damage_received)
    block_roll = rand(1..6)
    if block_roll <= @shield_level
      puts "--------------------------------------------------"
      puts "CRITICAL BLOCK ! #{@name} successfully blocked incoming attack with his Shield !"
      puts "0 damage taken."
      puts "--------------------------------------------------"
      return
    end
    super(damage_received)
  end

# HumanPlayer Actions #
# -------------------------------#
  def search_shield()
    found_shield_lvl = rand(1..5)
    puts "You have found a level #{found_shield_lvl} shield."
    if found_shield_lvl > @shield_level
      puts "+#{found_shield_lvl - @shield_level} lvl shield upgrade."
      @shield_level = found_shield_lvl
      puts "Great ! A solid one. You keep it !"
    else 
      puts "No luck, this one is trash."
    end
  end

  def search_armor()
    dice = rand(1..6)
    if dice == 1
      puts "Nothing..."
    elsif dice == 2
      puts "You have found small armor plate (+5 armor)."
      @armor_points = @armor_points + 5
      if @armor_points > 40
        @armor_points = 40
      end
    elsif dice >= 3 && dice <= 5
      puts "You have found thick armor plate (+10 armor)."
      @armor_points = @armor_points + 10
      if @armor_points > 40
        @armor_points = 40
      end
    else
      puts "You have found mighty armor plate (+20 armor)."
      @armor_points = @armor_points + 20
      if @armor_points > 40
        @armor_points = 40
      end
    end
    puts "You have now #{@armor_points} armor points !"
  end

  def search_weapon()
    found_weapon_lvl = rand(1..10)
    puts "You have found a level #{found_weapon_lvl} weapon."
    if found_weapon_lvl > @weapon_level
      puts "+#{found_weapon_lvl - @weapon_level} lvl weapon upgrade."
      @weapon_level = found_weapon_lvl
      puts "Great ! A better one. You keep it !"
    else 
      puts "No luck, its a shitty weapon."
    end
  end

  def search_health_pack()
    dice = rand(1..6)
    if dice == 1
      puts "Nothing..."
    elsif dice >= 2 && dice <= 5
      @life_points = @life_points + 50
      if @life_points > @max_life_points
        @life_points = @max_life_points
      end
      puts "You have found one +50 health pack !"
    else
      @life_points = @life_points + 80
      if @life_points > @max_life_points
        @life_points = @max_life_points
      end
      puts "You have found one +80 health pack ! Sweet."
    end
  end
end
#binding.pry