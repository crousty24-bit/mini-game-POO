require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'game'
require 'player'

# v3.0
puts "------------------------------------------------"
puts "|         Welcome to THP Battle Arena.         |"
puts "|     Last Dev standing is the winner, yay!    |"
puts "-------------------------------------------------"

puts "Please enter your gamer tag : "
user_name = gets.chomp
my_game = Game.new(user_name)

while my_game.is_still_ongoing?
  my_game.show_players
  my_game.new_players_in_sight
  my_game.menu
  
  puts "ENTER :"
  action = gets.chomp
  my_game.menu_choice(action)
  
  my_game.enemies_attack
  
  puts "-------------------------------------------"
end

my_game.end_game