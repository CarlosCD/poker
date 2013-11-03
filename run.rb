#!/usr/bin/ruby

require './poker_deck'

# poker_hand is already required by poker_deck
# require './poker_hand'

deck = PokerDeck.new
deck.shuffle!
hand = deck.hand  # taken from the beginning, not randomly, as the deck has already been shuffled

puts "The hand, as it comes from the deck:   #{hand}"
hand.order!
puts "Same hand, ordered:                    #{hand}"

puts "The hand type:                         #{hand.poker_hand}"

# Some other examples at other_examples.rb
