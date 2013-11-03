require 'rspec'
require './poker_deck'
# require './poker_hand'

describe PokerDeck do

  before(:each) do
    @my_deck = PokerDeck.new
  end

  it 'deals a hand, an instance of the PokerHand class' do
    hand = @my_deck.hand
    hand.should_not be_nil
    hand.should be_an_instance_of(PokerHand)
  end

  it 'gives the same hand if the deck has no changes (as when no shuffle occurred)' do
    first_hand = @my_deck.hand
    second_hand = @my_deck.hand
    first_hand.should eq(second_hand)
  end

  it 'changes the hand after shuffling' do
    first_hand = @my_deck.hand
    @my_deck.shuffle!
    shuffled_hand = @my_deck.hand
    first_hand.should_not eq(shuffled_hand)
  end

end
