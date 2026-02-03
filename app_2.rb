require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# v2.0
puts "------------------------------------------------"
puts "|         Welcome to THP Battle Arena.         |"
puts "|     Last Dev standing is the winner, yay!    |"
puts "-------------------------------------------------"

puts "Please enter your gamer tag : "
user_name = gets.chomp
puts "------------------------------"
player_user = HumanPlayer.new("#{user_name}")
puts "#{player_user.show_state()}"
puts "------------------------------"
puts "Generating mighty adversaries ..."
player1 = Player.new("Gork")
player2 = Player.new("Sudo")
enemy = [player1, player2]
puts "------------------------------"

puts "All Players ready in arena :"
puts "#{player_user.show_state()}"
puts "#{player1.show_state()}"
puts "#{player2.show_state()}"
puts "------------------------------"
puts "--- LET THE FIGHT BEGIN ---"

while player_user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts "------------------------------"
  puts "#{player_user.show_state()}"
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
  if action == "a"
    player_user.search_weapon
  elsif action == "s"
    player_user.search_health_pack
  elsif action == "1"
    player_user.attacks(player1)
  elsif action == "2"
    player_user.attacks(player2)
  end
  puts "Your turn is over."
  puts "-----------------------------------------"
  puts "Prepare yourself! Enemy players now attacks !"
  enemy.each do |player|
    if player.life_points > 0
      player.attacks(player_user)
    end
  end
end

puts "------ GAME ENDED ------"
if player_user.life_points > 0
  puts "Congrats ! You are the last Dev standing."
else
  puts "GameOver. You're dead.."
end
binding.pry