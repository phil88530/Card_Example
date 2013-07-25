class Card
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(Spade Heart Club Diamond)
  def initialize(num)
    @suit = RANKS[num%13]
    @value =SUITS[num%4]
  end
end

class Deck
  def initialize()
    @deck = (0..51).to_a.shuffle.collect{|card_num| Card.new(card_num)}
  end
end
