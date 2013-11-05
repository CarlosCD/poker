class PokerHand

  def initialize(coded_hand)
    if valid? coded_hand
      @hand = coded_hand                   # [:s3, :d7, :h5, :dA, :c1]
      @encoded = ordered_numeric_encoding  # [{suit: 's',value: 3},{suit: 'd',value: 7},...,{suit: 'c',value: 14}]
      @values = hand_values                # [3, 7, 5, 10, 14]
    else
      raise 'Invalid hand!'
    end
  end

  def order!
    @hand = @encoded.collect{ |card| (card[:suit] + value_to_code(card[:value])).to_sym }
  end

  def coded_info
    @hand.to_s
  end

  def to_s
    printable_hand = @hand.collect do |card|
      card = card.to_s
      suit = case card[0]
             when 'c' then 'clubs'
             when 'd' then 'diamonds'
             when 'h' then 'hearts'
             when 's' then 'spades'
             end
      value = case card[1]
              when '1' then 'Ace'
              when '2'..'9' then card[1]
              when 'A' then '10'
              when 'J' then 'Jack'
              when 'Q' then 'Queen'
              when 'K' then 'King'
              end
      "#{value} of #{suit}"
    end
    printable_hand.to_s
  end

  def poker_hand
    case
    when hand_is?(royal_flush) then 'Royal Flush'
    when hand_is?(straight_flush) then 'Straight flush'
    when hand_is?(four_of_a_kind) then 'Four of a kind'
    when hand_is?(full_house) then 'Full house'
    when hand_is?(flush) then 'Flush'
    when hand_is?(straight) then 'Straight'
    when hand_is?(three_of_a_kind) then 'Three of a kind'
    when hand_is?(two_pair) then 'Two Pair'
    when hand_is?(pair) then 'Pair'
    else 'High card'
    end
    # Alternative implementation (same idea, maybe less clear):
    # ---
    # poker_hands = ['Royal Flush', 'Straight flush', 'Four of a kind', 'Full house', 'Flush',
    #                'Straight', 'Three of a kind', 'Two Pair', 'Pair']
    # hand_type = poker_hands.detect{ |ph| hand_is?(self.send ph.downcase.gsub(' ','_').to_sym) }
    # hand_type || 'High card'
    # ---
    #  Note: this part shculd be extracted to a private method:
    #     ph.downcase.gsub(' ','_').to_sym
    #  It transforms the poker hand String into a snake_case symbol, i.e. 'Three of a kind' #=> :three_of_a_kind
  end

  # For testing purposes
  def ==(other_hand)
    @hand == other_hand.instance_variable_get(:@hand)
  rescue
    false
  end

  private

  def valid?(hand)
    valid = hand.is_a?(Array) && (hand.length == 5)
    valid = (hand.select{|card| card.is_a?(Symbol) && card.to_s.length == 2}.length == 5) if valid
    if valid
      strings = hand_as_string_array(hand)  # [['d','9'], ..., ['h', 'A']]
      valid = (strings.select{|card| ['c','d','h','s'].include?(card[0]) && (('1'..'9').to_a + ['J','Q','K','A']).include?(card[1])}.length == 5)
    end
    # Repetions not allowed (this may need to change if more than one deck of cards is used)
    valid = (hand == hand.uniq) if valid
    valid
  end

  def ordered_numeric_encoding
    result = hand_as_string_array(@hand) # [['d','9'], ..., ['h', 'A']]
    # Cards as a hash of suits and values:
    result = result.collect{ |card| {suit: card[0], value: code_to_value(card[1])} }
    # Order by value, and then by suit:
    result.sort do |a, b|
      ((a[:value] <=> b[:value]) != 0) ? (a[:value] <=> b[:value]) : (a[:suit] <=> b[:suit])
    end
  end

  def hand_values
    @encoded.collect{|card| card[:value]}
  end

  def max_repetition(unique_values)
    unique_values.collect{ |v| @values.count(v) }.max
  end

  def hand_is?(options)
    valid = true
    uniques = @values.uniq
    valid = (uniques.length == options[:unique_values]) if options[:unique_values]
    valid = (max_repetition(uniques) == options[:larger_group]) if valid && options[:larger_group]
    valid = (uniques[4] == uniques[0]+4) if valid && options[:consecutive]
    valid = @encoded.collect{|card| card[:suit]}.uniq.length == options[:suits] if valid && options[:suits]
    valid = (uniques[4] == options[:higher_card]) if valid && options[:higher_card]
    valid
  end

  def pair
    { unique_values: 4 }
  end

  def two_pair
    { unique_values: 3, larger_group: 2 }
  end

  def three_of_a_kind
    { unique_values: 3, larger_group: 3 }
  end

  def straight
    { unique_values: 5, consecutive: true }
  end

  def flush
    { suits: 1 }
  end

  def full_house
    { unique_values: 2, larger_group: 3 }
  end

  def four_of_a_kind
    { unique_values: 2, larger_group: 4 }
  end

  def straight_flush
    { unique_values: 5, consecutive: true,  suits: 1 }
  end

  def royal_flush
    { unique_values: 5, consecutive: true,  suits: 1, higher_card: 14 }
  end

  # Utility private methods:

  def hand_as_string_array(hand)
    result = hand.collect(&:to_s)    # ['d9', ..., 'hA']
    result.collect(&:chars)           # [['d','9'], ..., ['h', 'A']]
  end

  # '2'...'9','A','J'','Q','K','1' #=> 2,...,9,10,11,12,13,14
  def code_to_value(char_code)
    case char_code
    when '1' then 14
    when '2'..'9' then char_code.to_i
    when 'A' then 10
    when 'J' then 11
    when 'Q' then 12
    when 'K' then 13
    end
  end

  # 2,...,9,10,11,12,13,14 #=> '2'...'9','A','J'','Q','K','1'
  def value_to_code(value)
    (('2'..'9').to_a + ['A','J','Q','K','1'])[value-2]
  end

end
