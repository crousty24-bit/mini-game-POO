class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left
  def initialize(human_player_name)
    @human_player = HumanPlayer.new(human_player_name)
    @players_left = 10
    @enemies_in_sight = []
  end
  def kill_player(player)
    @enemies_in_sight.delete(player) #remove player when killed
    @players_left = @players_left - 1 #total change
  end
  def is_still_ongoing?()
    return @human_player.life_points > 0 && @players_left >= 1
  end
  def new_players_in_sight()
    if @enemies_in_sight.length == @players_left
      puts "All enemies already in sight."
      return
    end
    dice = rand(1..6)
    possibles_names = ["Gork", "Claude", "Sudo", "Vim", "Ruby", "Python", "Git", "Terminal",
              "Bash", "Linux", "Docker", "Pixel", "Bug", "Root", "Echo", "Nano", "Java", "Kernel"]
    if dice == 1
      puts "No new enemy coming for now.."
    elsif dice >= 2 && dice <= 4
      random_name = possibles_names.sample
      new_enemy = Player.new(random_name)
      @enemies_in_sight << new_enemy
      puts "Beware! A new enemy appears from the shadows !"
      puts "#{new_enemy.name}"
    else
      random_name1 = possibles_names.sample
      random_name2 = possibles_names.sample
      new_enemy1 = Player.new(random_name1)
      new_enemy2 = Player.new(random_name2)
      @enemies_in_sight << new_enemy1
      @enemies_in_sight << new_enemy2
      puts "Watch out! 2 new enemies in sight !"
      puts "#{new_enemy1.name} & #{new_enemy2.name}"
    end
  end
  def show_players()
    puts "#{@human_player.show_state}"
    puts "Only #{@players_left} players left !"
  end
  def menu()
    puts "------------------------------"
    puts "Choose an action :"
    puts "a - search for a better weapon"
    puts "s - search for a health pack"
    puts "d - search for armor piece"
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
  def enemies_attack()
    puts "Enemy players will now attack !"
    @enemies_in_sight.each do |enemy|
      enemy.attacks(@human_player)
    end
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