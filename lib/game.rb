class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left
  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name)
    @players_left = 10
    @enemies_in_sight = []
  end
  def kill_player(player)
    @enemies_in_sight.delete(player) #remove bot player when killed
    @players_left = @players_left - 1 #update total change
  end
  def is_still_ongoing?
    return @human_player.life_points > 0 && @players_left >= 1
  end

# Refacto : add new players in sight #
  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "All enemies already in sight."
      return
    end
    dice = rand(1..6)
    spawn_count =
    if dice == 1
      puts "No new enemy coming for now.."
      0
    elsif dice <= 4
      puts "Beware! A new enemy appears from the shadows !"
      1
    else
      puts "Watch out! 2 new enemies in sight !"
      2
    end
    spawn_count = [spawn_count, @players_left].min
    possible_names = ["Gork", "Claude", "Sudo", "Vim", "Ruby", "Python", "Git", "Terminal",
              "Bash", "Linux", "Docker", "Pixel", "Bug", "Root", "Echo", "Nano", "Java", "Kernel"]
    spawn_count.times do
      name = possible_names.sample
      new_enemy = Player.new(name)
      @enemies_in_sight << new_enemy
      @players_left -= 1
      puts "Enemy Player: #{name}"
    end
  end

  def show_players
    @human_player.show_state
    puts "Only #{@players_left} enemies remaining !"
    puts "Currently in sight : #{@enemies_in_sight.length}"
  end
  
  def menu()
    puts "------------------------------"
    puts "Choose an action :"
    puts "a - search for a better weapon"
    puts "s - search for a health pack"
    puts "d - search for armor piece"
    puts "b - search for a better shield"
    puts "attack enemy in sight"
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index}"
      enemy.show_state
    end
  end
  def menu_choice(action)
    if action == "a"
      @human_player.search_weapon
    elsif action == "s"
      @human_player.search_health_pack
    elsif action == "d"
      @human_player.search_armor
    elsif action == "b"
      @human_player.search_shield
    else
      index = action.to_i
      if index < @enemies_in_sight.length && index >= 0
        enemy = @enemies_in_sight[index]
        @human_player.attacks(enemy)
        if enemy.life_points <= 0
          kill_player(enemy)
        end
      else
        puts "Invalid target or no enemy in sight !"
      end
    end
  end

# Bot targeting & attack Sequence #
# --------------------------------#
  def enemies_attack
    puts "Enemy players will now attack !"
    targets = {}
    @enemies_in_sight.each do |enemy|
      next if enemy.life_points <= 0 #prevent dead bot from attacking
      rng = rand(1..100)
        if @human_player.life_points > 0 && rng <= 50
          targets[enemy] = (@human_player)
        else
          possible_targets = @enemies_in_sight.select do |bot|
            bot.life_points > 0 && bot != enemy
          end
          if possible_targets.any?
            targets[enemy] = (possible_targets.sample)
          end
        end
    end
    targets.each do |enemy, target|
      enemy.attacks(target)
    end
    dead = @enemies_in_sight.select {|bot| bot.life_points <= 0} #select every dead bots
    @players_left = @players_left - dead.length #total change
    @enemies_in_sight.reject! {|bot| bot.life_points <= 0} #clean variable
  end

  def end_game()
    puts "------ GAME ENDED ------"
    if @human_player.life_points > 0
      puts "Congrats ! You are the last Dev standing."
    else
      puts "GameOver. You're dead.."
    end
  end
end