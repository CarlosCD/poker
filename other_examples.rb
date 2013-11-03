#!/usr/bin/ruby

require './poker_deck'

module OtherExamples
  class << self

    # Creating a deck and inspecting it
    def example1
      deck = PokerDeck.new
      puts "Initial Deck: #{deck}"
      puts '----'
      deck.shuffle!
      puts "Deck shuffled: #{deck}"
    end

    # Deals a random hand, inspects it in different ways, and shows the highest scoring poker hand
    def example2
      deck = PokerDeck.new
      deck.shuffle!
      hand = deck.hand
      puts "Hand generated, coded: #{hand.coded_info}"
      puts "In human format:       #{hand}"
      puts '----'
      hand.order!
      puts "Coded, and ordered:    #{hand.coded_info}"
      puts "In human format:       #{hand}"
      puts '----'
      puts "Poker hand name:       #{hand.poker_hand}"
    end

    # Creates a particular hand, inspects it, and shows the highest scoring poker hand
    def example3(hand_values)
      hand = PokerHand.new hand_values
      puts "Hand generated, coded: #{hand.coded_info}"
      puts "In human format:       #{hand}"
      puts '----'
      puts "Poker hand name:       #{hand.poker_hand}"
    end

    # Randomly looks for some specific set of poker hands...
    def example4 poker_hands
      deck = PokerDeck.new
      deck.shuffle!
      hand = deck.hand
      num = 1
      while !poker_hands.include?(hand.poker_hand)  do
        num += 1
        deck.shuffle!
        hand = deck.hand
        puts "[#{num}]  #{hand.coded_info}"
      end
      puts '----'
      hand.order!
      puts "The hand, coded and ordered:  #{hand.coded_info}"
      puts "Same hand, ordered:           #{hand}"
      puts "Poker hand type:              #{hand.poker_hand}"
    end

  end
end

# Uncomment and comment the examples as desired:

# OtherExamples.example1

# OtherExamples.example2

# OtherExamples.example3 [:hA, :hJ, :hQ, :hK, :h1]

# OtherExamples.example4 ['Flush']

OtherExamples.example4 ['Royal Flush', 'Straight flush', 'Four of a kind', 'Full house']
