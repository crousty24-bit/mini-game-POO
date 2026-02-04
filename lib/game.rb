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
    return True if @human_player.life_points > 0 && @players_left >= 1
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
    puts "1 - attack player1"
      if player1.life_points <= 0
        puts "Player1 dead."
      else
      puts player1.show_state
      end
    puts "2 - attack player2"
      if player2.life_points <= 0
        puts "Player2 dead."
      else
      puts player2.show_state
    end
  puts "ENTER :"
  action = gets.chomp
  puts "------------------------------"
  end
  def menu_choice(user_choice)
    if action == "a"
      player_user.search_weapon
    elsif action == "s"
      player_user.search_health_pack
    elsif action == "1"
      player_user.attacks(player1)
    elsif action == "2"
      player_user.attacks(player2)
    end
  end
end