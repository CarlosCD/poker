require 'rspec'
require './poker_hand'

describe PokerHand do

  POKER_HANDS = ['Royal Flush', 'Straight flush', 'Four of a kind', 'Full house', 'Flush',
                 'Straight', 'Three of a kind', 'Two Pair', 'Pair', 'High card']

  it "doesn't create an invalid hand" do
    -> { hand = PokerHand.new }.should raise_error, 'the hand should be created passing a value'
    -> { hand = PokerHand.new 'a string' }.should raise_error, 'the hand should be created passing an Array'
    -> { hand = PokerHand.new [:hK, :s1, :h1, :s1] }.should raise_error, 'the hand should have 5 cards, no less'
    -> { hand = PokerHand.new [:hK, :s1, :h1, :s1, :c1, :hA] }.should raise_error, 'the hand should have 5 cards, no more'
    -> { hand = PokerHand.new [:hK, 45, :h1, :s1, 1] }.should raise_error, 'the hand seed should contain only symbols'
    -> { hand = PokerHand.new [:h10, :s45, :h1, :s1, :card] }.should raise_error, 'the hand should contain valid symbols'
    -> { hand = PokerHand.new [:s1, :h1, :h1, :c1, :hA] }.should raise_error, 'the hand should not repeat cards (sigle deck)'
  end

  it 'creates valid hands' do
    hand = PokerHand.new random_hand_value
    hand.should_not be_nil
    hand.should be_an_instance_of(PokerHand)
  end

  it 'returns a valid poker hand when it is requested' do
    hand = PokerHand.new random_hand_value
    poker_hand = hand.poker_hand
    POKER_HANDS.should include(poker_hand)
  end

  it 'identifies a high card' do
    hand = PokerHand.new [:c3, :d4, :s9, :dQ, :h1]
    poker_hand = hand.poker_hand
    poker_hand.should eq('High card')
  end

  it 'identifies a pair' do
    hand = PokerHand.new [:d5, :s5, :s6, :h7, :d8]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Pair')
  end

  it 'identifies a Two Pair' do
    hand = PokerHand.new [:s8, :cA, :dA, :c1, :s1]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Two Pair')
  end

  it 'identifies a Three of a kind' do
    hand = PokerHand.new [:s5, :s7, :cK, :dK, :hK]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Three of a kind')
  end

  it 'identifies a Straight' do
    hand = PokerHand.new [:h3, :s4, :h5, :h6, :h7]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Straight')
  end

  it 'identifies a Flush' do
    hand = PokerHand.new [:c9, :cA, :c1, :c7, :c2]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Flush')
  end

  it 'identifies a Full house' do
    hand = PokerHand.new [:h5, :c2, :h2, :c5, :d5]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Full house')
  end

  it 'identifies a Four of a kind' do
    hand = PokerHand.new [:c2, :s3, :c3, :d3, :h3]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Four of a kind')
  end

  it 'identifies a Straight flush' do
    hand = PokerHand.new [:dA, :d9, :dJ, :d8, :dQ]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Straight flush')
  end

  it 'identifies a Royal Flush' do
    hand = PokerHand.new [:c1, :cJ, :cA, :cQ, :cK]
    poker_hand = hand.poker_hand
    poker_hand.should eq('Royal Flush')
  end

  private

  # Equivalent to creating a deck and dealing a random hand
  def random_hand_value
    values = (('1'..'9').to_a + ['A', 'J', 'Q', 'K'])
    suits = ['c', 'd', 'h', 's']
    deck_as_array_of_arrays = suits.product(values).sample(5)  # like ["h", "K"], ["s", "A"], ["c", "2"], ["d", "1"], ["c", "9"]]
    deck_as_strings = deck_as_array_of_arrays.collect(&:join)  # like ["hK", "sA", "c2", "d1", "c9"]
    deck_as_strings.collect(&:to_sym)                          # like [:hK, :sA, :c2, :d1, :c9]
  end

end
