require 'pry'
class Player
  attr_accessor :name, :life_points, :armor_points, :weapon_level
  def initialize(name)
    @name = name
    @life_points = 10
    possible_armor_values = [0, 5, 10, 20]
    @armor_points = possible_armor_values.sample #random armor value for bots
    possible_weapon_levels = [1, 2, 3, 4]
    @weapon_level = possible_weapon_levels.sample
  end
  def show_state()
    if @life_points > 0
      puts "Player #{@name} | #{@life_points}/10 HP | #{@armor_points}/20 Armor | Weapon LvL: #{@weapon_level}."
    end
  end
  def gets_damage(damage_received)
    final_damage = damage_received - @armor_points #armor reduce damage received
    if final_damage < 0 #condition to not get negative value
      final_damage = 0
    end
    @life_points = @life_points - final_damage
    if @life_points > 0 
      puts "Player #{@name} has taken #{final_damage} damage !"
    end
    if @life_points <= 0
      puts "Player #{@name} has been slayed !"
    end
  end
  def attacks(player)
    puts "Player #{@name} attacks player #{player.name} !"
    damage_points = compute_damage()
    if damage_points >= 18
      damage_points = damage_points * 2
      puts "It scores a Crit(double dmg) ! Attack inflict #{damage_points} damage !"
      player.gets_damage(damage_points)
    else
      puts "Attack inflict #{damage_points} damage."
      player.gets_damage(damage_points)
    end
  end
  def compute_damage()
    return rand(1..6) * @weapon_level
  end
end

class HumanPlayer < Player
  attr_accessor :name, :life_points, :weapon_level, :shield_level
  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
    @armor_points = 5
    @shield_level = 1
  end

  def show_state()
    if @life_points > 0
      puts "Player #{@name} | #{@life_points}/100 HP."
      puts "Weapon LvL: #{@weapon_level} (max10)."
      puts "#{@armor_points}/40 Armor."
      puts "Shield LvL: #{@shield_level} (max5)."
    end
  end

  def compute_damage()
    return rand(1..6) * @weapon_level
  end

  def gets_damage(damage_received)
    block_roll = rand(1..6)
    if block_roll <= @shield_level
      puts "--------------------------------------------------"
      puts "CRITICAL BLOCK ! #{@name} successfuly blocked incoming attack with his Shield !"
      puts "0 damage taken."
      puts "--------------------------------------------------"
      return
    end
    super(damage_received)
  end

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
#binding.pry