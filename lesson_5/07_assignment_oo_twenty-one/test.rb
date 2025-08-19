require 'yaml'
require 'pry-byebug'

module Displayable
  def clear
    system('clear')
  end

  def prompt(message)
    puts "=> #{message}"
  end

  def prompt_game_text(key, *arguments)
    prompt(format(Game::GAME_TEXT[key], *arguments))
  end

  def display_welcome_message
    prompt_game_text('welcome')
    prompt_game_text('rounds_to_win', Game::ROUNDS_TO_WIN)
  end

  # def display_rules
  # end

  def display_goodbye_message
    prompt_game_text('goodbye')
  end
end

class Deck
  include Displayable

  attr_reader :deck

  def initialize
    @deck = new_deck.shuffle!
  end

  def new_deck
    deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        deck << Card.new(suit, rank)
      end
    end

    deck
  end

  def shuffle!
    @deck.each do |card|
      current_card = @deck.delete(card)
      random_idx = (0..@deck.size).to_a.sample
      @deck.insert(random_idx, current_card)
    end
  end

  def deal_a_card!
    card_dealt = @deck.shift
    prompt_game_text('display_card_dealt', card_dealt.translate)
    card_dealt
  end
end

class Card
  SUITS = ['clubs', 'diamonds', 'hearts', 'spades']
  RANKS = %w(2 3 4 5 6 7 8 9 10 ace jack king queen)

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def value
    if @rank == 'ace'
    end

    if ('2'..'10').include?(@rank)
      @rank.to_i
    elsif ace?
      :undetermined
    else
      10
    end
  end

  def ace?
    @rank == 'ace'
  end

  def translate
    suit = @suit
    rank = @rank
    rank.capitalize! if !('2'..'10').include?(rank)
    suit.capitalize!
    "#{@rank} of #{@suit}"
  end
end

class Participant
  attr_reader :cards, :deck
  attr_accessor :total, :score

  def initialize(deck)
    @deck = deck
    @cards = []
    @total = 0
    @score = 0
  end

  def hit
    puts "#{self.class} hits!"
    @cards << @deck.deal_a_card!
  end

  def stay
    puts "#{self.class} stays."
  end

  def update_total
    # puts "update_total is called on #{self.class}"
    # puts "#{self.class}'s cards are: #{self.cards}"
    # binding.pry if self.cards.any? { |card| card.ace? }
    num_aces = number_of_aces
    sum_without_ace = @cards.sum { |card| card.ace? ? 0 : card.value }
    sum = sum_without_ace + Game::ACE_VALUE_MAX * num_aces

    aces_as_11 = num_aces
    aces_as_1 = 0

    until aces_as_1 == num_aces || sum <= Game::ACE_VALUE_DETERMINANT
      sum = sum - Game::ACE_VALUE_MAX + Game::ACE_VALUE_MIN
      aces_as_11 -= 1
      aces_as_1 += 1
    end

    self.total = sum
    puts "#{self.class}'s total is #{self.total} immediately after update"
  end

  # def collect_all_aces!
  #   aces = []
  #   each do |card|
  #     (aces << delete(card)) if card.rank == 'ace'
  #   end
  # end

  def number_of_aces
    cards.select { |card| card.ace? }.size
  end

  def busted?
    total > 21
  end

  def return_all_cards_to_deck
    cards.each { |card| deck.deck << card }
    cards.clear
  end
end

class Player < Participant
  def format_initial_cards
    cards[0..1].map(&:translate).join(', ')
  end
end

class Dealer < Participant
  def format_initial_cards
    cards.first.translate
  end

  def format_all_cards
    cards.map(&:translate).join(', ')
  end
end

class Game
  include Displayable

  GAME_TEXT = YAML.load_file('21_game_text.yml')
  ACE_VALUE_MAX = 11
  ACE_VALUE_MIN = 1
  ACE_VALUE_DETERMINANT = 21
  DEALER_STAY_MINIMUM = 17
  NUM_INITIAL_CARDS = 2
  ROUNDS_TO_WIN = 3

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
  end

  def start
    display_welcome_message
    # display_rules if display_rules?
    main_game
    display_goodbye_message
  end

  def main_game
    loop do
      single_set_of_rounds
      display_grand_winner
      break unless play_again?
    end
  end

  def single_set_of_rounds
    loop do
      single_round
      tally_scores
      display_scores
      break if grand_winner?
      reset
    end
  end

  def single_round
    deal_initial_cards
    show_initial_cards_and_totals
    player_turn
    dealer_turn if !player.busted?
    show_totals
    show_result
  end

  def deal_initial_cards
    NUM_INITIAL_CARDS.times do
      player.cards << deck.deck.shift 
      dealer.cards << deck.deck.shift
    end
  end

  def show_initial_cards_and_totals
    prompt_game_text('display_player_initial_cards',
                     player.format_initial_cards)
    player.update_total
    dealer.update_total
    prompt_game_text('display_player_total', player.total)
    prompt_game_text('display_dealer_initial_cards',
                     dealer.format_initial_cards)
  end

  def player_turn
    loop do
      if hit?
        player.hit
        player.update_total
        prompt_game_text('display_player_total', player.total)
        break if player.busted?
      else
        player.stay
        break
      end
    end
  end

  def hit_or_stay
    prompt_game_text('hit_or_stay')
    user_input = nil

    loop do
      user_input = gets.chomp.downcase
      break if %w(h hit s stay).include?(user_input)
      prompt_game_text('invalid_choice')
    end

    user_input = user_input[0]
  end

  def hit?
    hit_or_stay == 'h'
  end

  def stay?
    hit_or_stay == 's'
  end

  def dealer_turn
    prompt_game_text('display_dealer_cards', dealer.format_all_cards)
    prompt_game_text('display_dealer_total', dealer.total)
    loop do
      if dealer.total < DEALER_STAY_MINIMUM
        dealer.hit
        dealer.update_total
        prompt_game_text('display_dealer_total', dealer.total)
        break if dealer.busted?
      else
        dealer.stay
        break
      end
    end
  end

  def show_result
    prompt_game_text('player_busted') if player.busted?
    prompt_game_text('dealer_busted') if dealer.busted?

    case round_winner
    when player then prompt_game_text('round_winner_player')
    when dealer then prompt_game_text('round_winner_dealer')
    when nil then prompt_game_text('round_tie')
    end
  end

  def round_winner
    if player.busted?
      dealer
    elsif dealer.busted?
      player
    elsif player.total > dealer.total
      player
    elsif player.total < dealer.total
      dealer
    elsif player.total == dealer.total
      nil
    end
  end

  def show_totals
    prompt_game_text('display_both_totals', player.total, dealer.total)
  end

  def grand_winner?
    player.score == ROUNDS_TO_WIN || dealer.score == ROUNDS_TO_WIN
  end

  def tally_scores
    case round_winner
    when player then player.score += 1
    when dealer then dealer.score += 1
    end
  end

  def display_scores
    prompt_game_text('display_scores', player.score, dealer.score)
  end

  def grand_winner?
    player.score == ROUNDS_TO_WIN || dealer.score == ROUNDS_TO_WIN
  end

  def reset
    player.return_all_cards_to_deck
    dealer.return_all_cards_to_deck
    deck.shuffle!
  end
end

# Game.new.start

deck = Deck.new
dealer = Dealer.new(deck)

deck.deck.each do |card|
  if card.rank == '5'
    dealer.cards << card
    deck.deck.delete(card)
    break
  end
end

deck.deck.each do |card|
  if card.rank == 'jack'
    dealer.cards << card
    deck.deck.delete(card)
    break
  end
end

p dealer.cards
p dealer.total
dealer.update_total

deck.deck.each do |card|
  if card.rank == 'ace'
    dealer.cards << card
    deck.deck.delete(card)
    break
  end
end

p dealer.cards
dealer.update_total
p dealer.total