require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Gork")
player2 = Player.new("Sudo")

puts "Players ready in arena :"
puts "#{player1.show_state()}"
puts "#{player2.show_state()}"

while player1.life_points > 0 && player2.life_points > 0
  puts "Let the fight begin !"
  player2.attacks(player1)
  if player1.life_points <= 0
    break
  end
  puts "#{player1.show_state()}"
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  end
  puts "#{player2.show_state()}"
end
binding.pry