# Expanded upon 4_history_of_moves.rb
require 'pry'

class Player
  attr_accessor :move, :name, :points

  def initialize
    set_name
    @points = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, please enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts 'Please choose rock, paper, scissors, spock, or lizard:'
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
end

class R2D2 < Computer
  # "Loyal, plucky, and resourceful." - Grok 4
  def set_name
    self.name = 'R2D2'
  end

  # Only chooses either rock or scissors
  def choose(_)
    self.move = Move.new(['rock', 'scissors'].sample)
  end
end

class HAL < Computer
  # "Calm, calculated, and chillingly logical." - Grok 4'
  def set_name
    self.name = 'HAL 9000'
  end

  # Pretty good at the game. High chance (at least 66%) of winning
  def choose(human_move)
    self.move = Move.new(case human_move
                         when 'rock'
                           ['paper', 'spock', Move::VALUES.sample].sample
                         when 'paper'
                           ['scissors', 'lizard', Move::VALUES.sample].sample
                         when 'scissors'
                           ['rock', 'spock', Move::VALUES.sample].sample
                         when 'spock'
                           ['lizard', 'paper', Move::VALUES.sample].sample
                         when 'lizard'
                           ['rock', 'scissors', Move::VALUES.sample].sample
                         end)
  end
end

class Chappie < Computer
  # Curious, naive, and empathetic." - Grok 4
  def set_name
    self.name = 'Chappie'
  end

  # Plays the game properly. Chooses a move at random
  def choose(_)
    self.move = Move::VALUES.sample
  end
end

class Sonny < Computer
  # "Introspective, emotional, and philosophical." - Grok 4
  def set_name
    self.name = 'Sonny'
  end

  # Also pretty good at the game, but has a penchant for choosing spock somehow
  def choose(human_move)
    self.move = Move.new(case human_move
                         when 'rock'
                           ['paper', 'spock', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         when 'paper'
                           ['scissors', 'lizard', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         when 'scissors'
                           ['rock', 'spock', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         when 'spock'
                           ['lizard', 'paper', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         when 'lizard'
                           ['rock', 'scissors', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         end)
  end
end

class Number5 < Computer
  # "Playful, inquisitive, and endearing." - Grok 4
  def set_name
    self.name = 'Number 5'
  end

  # Does his best to be annoying by always tying the game
  def choose(human_move)
    self.move = Move.new(case human_move
                         when 'rock'
                           ['rock', 'rock', 'rock',
                            Move::VALUES.sample].sample
                         when 'paper'
                           ['paper', 'paper', 'paper',
                            Move::VALUES.sample].sample
                         when 'scissors'
                           ['scissors', 'scissors', 'scissors',
                            Move::VALUES.sample].sample
                         when 'spock'
                           ['spock', 'spock', 'spock',
                            Move::VALUES.sample].sample
                         when 'lizard'
                           ['lizard', 'lizard', 'lizard',
                            Move::VALUES.sample].sample
                         end)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.lizard? || other_move.paper?))
  end

  def to_s
    @value
  end
end

class GameHistory
  attr_accessor :record

  def initialize
    @record = {}
  end

  def add_new_series(series_number)
    @record[series_number] = {}
  end

  def add_new_round(series_number, round_number)
    @record[series_number][round_number] = {}
  end

  def update_human_moves(series_number, round_number,
                         human_name, human_move)
    @record[series_number][round_number][human_name] = human_move
  end

  def update_computer_moves(series_number, round_number,
                            computer_name, computer_move)
    @record[series_number][round_number][computer_name] = computer_move
  end

  def update_round_winner(series_number, round_number, round_winner_name)
    @record[series_number][round_number][:round_winner] = round_winner_name
  end

  def series_history(series_number, human_name, computer_name)
    record[series_number].each do |round, round_details|
      puts "Round #{round}: #{human_name} → #{round_details[human_name]} " \
           "#{computer_name} → #{round_details[computer_name]} " \
           "| #{if round_details[:round_winner].nil?
                  'Tie'
                else
                  "#{round_details[:round_winner]} won"
                end}"
    end
  end
end

# Game Orchestration Engine
class RPSGame
  POINTS_TO_WIN = 2
  COMPUTERS = [R2D2, HAL, Number5, Sonny, Chappie]

  attr_accessor :human, :computer, :record, :series_number, :round_number,
                :round_winner

  def initialize
    @human = Human.new
    @computer = COMPUTERS.sample.new
    @record = GameHistory.new
    @series_number = 0
    @round_number = 0
  end

  def clear_screen
    system('clear')
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors! #{human.name}!"
    puts "Win #{POINTS_TO_WIN} points to be the GRAND WINNER!"
    puts "Your opponent is #{computer.name}! Get ready!"
    sleep(2.5)
  end

  def increment_series_number
    self.series_number = series_number + 1
  end

  def update_record_series
    record.add_new_series(series_number)
  end

  def increment_round_number
    self.round_number = round_number + 1
  end

  def reset_round_number
    self.round_number = 0
  end

  def display_move_options
    puts "Scissors cuts Paper    | Paper covers Rock\n" \
         "Rock crushes Lizard    | Lizard poisons Spock\n" \
         "Spock smashes Scissors | Scissors decapitates Lizard\n" \
         "Lizard eats Paper      | Paper disproves Spock\n" \
         'Spock vaporizes Rock   | Rock crushes Scissors'
    puts
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def determine_round_winner
    @round_winner = (if human.move > computer.move
                       human
                     elsif human.move < computer.move
                       computer
                     end)
  end

  def display_round_winner
    case round_winner
    when human
      puts "#{human.name} won this round!"
    when computer
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def tally_scores
    if round_winner == human
      human.points += 1
    elsif round_winner == computer
      computer.points += 1
    end
  end

  def update_record_round
    record.add_new_round(series_number, round_number)
    record.update_human_moves(series_number, round_number,
                              human.name, human.move.value)
    record.update_computer_moves(series_number, round_number,
                                 computer.name, computer.move.value)
    record.update_round_winner(series_number, round_number, round_winner&.name)
  end

  def display_scores
    puts "#{human.name}'s score: #{human.points}"
    puts "#{computer.name}'s score: #{computer.points}"
  end

  def reached_winning_points?
    human.points == POINTS_TO_WIN || computer.points == POINTS_TO_WIN
  end

  def display_grand_winner
    if human.points == POINTS_TO_WIN
      puts "#{human.name} is the GRAND WINNER! Woohoo! Congrats!"
    else
      puts "#{computer.name} is the GRAND WINNER."
    end
  end

  def view_series_history?
    answer = nil
    loop do
      puts "Would you like to view this series's history? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def view_series_history
    record.series_history(series_number, human.name, computer.name)
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts 'Sorry, must be y or n.'
    end

    answer == 'y'
  end

  def change_computer?
    answer = nil
    loop do
      puts "Do you want to play against a different opponent? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def change_computer
    current_robot = computer.class
    until computer.class != current_robot
      self.computer = COMPUTERS.sample.new
    end
    puts "Your new opponent is #{computer.name}! Get ready!"
    sleep(2.5)
  end

  def reset_points
    human.points = 0
    computer.points = 0
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors, Rock, Lizard. Good bye!'
  end

  def a_single_round
    increment_round_number
    display_move_options
    human.choose
    computer.choose(human.move.value)
    display_moves
    sleep(1)
    determine_round_winner
    display_round_winner
    tally_scores
    display_scores
    update_record_round
  end

  def play
    display_welcome_message

    loop do
      increment_series_number
      clear_screen
      update_record_series
      loop do
        a_single_round
        sleep(2)
        clear_screen
        if reached_winning_points?
          display_grand_winner
          view_series_history if view_series_history?
          break
        end
      end
      break unless play_again?
      change_computer if change_computer?
      reset_points
      reset_round_number
      clear_screen
    end

    display_goodbye_message
  end
end

RPSGame.new.play
