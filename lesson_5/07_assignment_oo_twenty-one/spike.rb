class Player
  def initialize
    # What would be the 'data' or 'states' of a Player object entail?
    # Maybe cards or a name?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Dealer
  def initialize
  end

  def deal
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant
  # What goes in here? All the redundant behaviours from Player and Dealer?
end

class Deck
  def initialize
    # Obviously, we need some data structure to keep track of cards
    # Array, hash, or something else?
  end

  def deal
    # Does the dealer or the deck deal?
  end
end

class Card
  def initialize
    # What are the 'states' of a card?
  end
end

class Game
  def start
    # What is the sequence of steps to execute the gameplay?
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start
