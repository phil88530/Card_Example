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
  end

  def sort_cards
    @cards.sort!{|a,b| a.card_value <=> b.card_value }
  end
end

d = Deck.new
p = PokerHand.new(d.cards.sample(5))
puts p.cards.to_s
