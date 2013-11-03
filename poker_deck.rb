require './poker_hand'

class PokerDeck

  # Using 'A' to encode the card value 10, as in hexadecimal, to keep cards encoded with 2 characters (suit + value)
  # This could be written as a single method chain as:
  #   ['c','d','h','s'].product(('1'..'9').to_a + ['A', 'J', 'Q', 'K']).collect(&:join).collect(&:to_sym)
  # But I believe this is a bit more legible
  def initialize
    values = ('1'..'9').to_a + ['A', 'J', 'Q', 'K']            # ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "J", "Q", "K"]
    suits = ['c', 'd', 'h', 's']                               # clubs, diamonds, hearts & spades
    deck_as_array_of_arrays = suits.product(values)            # ["c", "1"], ["c", "2"], ... ["s", "J"], ["s", "Q"], ["s", "K"]]
    deck_as_strings = deck_as_array_of_arrays.collect(&:join)  # ["c1", "c2", "c3", "c4", "c5", ... "s9", "sA", "sJ", "sQ", "sK"]
    @deck = deck_as_strings.collect(&:to_sym)                  # [:c1, :c2, :c3, :c4, :c5, :c6, ... :s8, :s9, :sA, :sJ, :sQ, :sK]
  end

  def shuffle!
    @deck.shuffle!
  end

  def hand(number = 5, random = false)
    random ? PokerHand.new(@deck.sample(number)) : PokerHand.new(@deck.first(number))
  end

  def to_s
    @deck.to_s
  end

end
