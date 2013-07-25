class Card
  attr_accessor :suit, :value  
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(Spade Heart Club Diamond)

  Rank_Values = {
    '2' =>  2,
    '3' =>  3,
    '4' =>  4,
    '5' =>  5,
    '6' =>  6,
    '7' =>  7,
    '8' =>  8,
    '9' =>  9,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  def initialize(num)
    @suit = SUITS[num%4]
    @value= RANKS[num%13]
  end

  def card_value
    Rank_Values[@value]
  end

  def to_s
    "#{@suit} #{@value}"
  end
end

class Deck
  attr_accessor :cards

  def initialize()
    @cards = (0..51).to_a.shuffle.collect{|card_num| Card.new(card_num)}
  end
end

class PokerHand
  attr_accessor :cards
  def initialize(cards = [])
    @cards = cards
    self.sort_cards #auto sort cards when init
    puts "Getting cards:" + @cards.to_s
  end

  def sort_cards
    @cards.sort!{|a,b| a.card_value <=> b.card_value }
  end

  #order cards
  def ordered_cards
    card_hash = Hash.new(0)
    @cards.each do |c|
      card_hash[c.value] += 1
    end

    card_hash
  end

  def rank
    if is_straight_flush?
      8
    elsif is_four_of_a_kind?
      7
    elsif is_full_house?
      6
    elsif is_flush?
      5
    elsif is_straight?
      4
    elsif is_three_of_a_kind?
      3
    elsif is_two_pairs?
      2
    elsif is_pair?
      1
    else  #must be high card
      0
    end
  end

  #methods for getting card kinds
  def is_straight_flush?
    is_straight_flush = true
    for i in 1..(@cards.count - 1)
      is_straight_flush = false if (@cards[i].card_value - @cards[i-1].card_value != 1) || (@cards[i].suit != @cards[i-1].suit)
    end

    is_straight_flush
  end

  def is_four_of_a_kind?
    ordered_cards.has_value?(4)
  end

  def is_full_house?
    od = ordered_cards
    od.has_value?(3) && od.has_value?(2) 
  end

  def is_flush?
    is_flush = true
    for i in 1..(@cards.count - 1)
      is_flush = false if (@cards[i].suit != @cards[i-1].suit)
    end

    is_flush
  end

  def is_straight?
    is_straight = true
    for i in 1..(@cards.count - 1)
      is_straight = false if (@cards[i].card_value - @cards[i-1].card_value != 1)
    end

    is_straight
  end

  def is_three_of_a_kind?
    ordered_cards.has_value?(3)
  end

  def is_two_pairs?
    ordered_cards.values.count(2) == 2
  end

  def is_pair?
    ordered_cards.values.count(2) == 1
  end
end

d = Deck.new
p1 = PokerHand.new(d.cards.sample(5))
p2 = PokerHand.new(d.cards.sample(5))
puts "p1 is rank #{p1.rank}"
puts "p2 is rank #{p2.rank}"

