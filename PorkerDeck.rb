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
  end

  def sort_cards
    @cards.sort!{|a,b| a.card_value <=> b.card_value }
  end


  def is_flush
    is_flush = false
    for i in 1..(@cards.count - 1)
      puts i
      is_flush = (@cards[i].card_value - @cards[i-1].card_value == 1)
    end

    is_flush
  end

  #order cards
  def ordered_cards
    card_hash = Hash.new(0)
    @cards.each do |c|
      card_hash[c.value] += 1
    end

    card_hash
  end
end

d = Deck.new
p = PokerHand.new(d.cards.sample(5))
puts "Getting cards:" + p.cards.to_s
puts "A hand has values:" + p.ordered_cards.to_s
