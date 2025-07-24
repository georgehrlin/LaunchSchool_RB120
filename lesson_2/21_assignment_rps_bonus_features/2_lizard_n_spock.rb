# Expanded upon 1_keeping_score.rb
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
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
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

  # Metrics/AbcSize: Assignment Branch Condition size for > is too high. [<0, 15, 14> 20.52/18]
  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  # Original
  # Metrics/AbcSize: Assignment Branch Condition size for > is too high. [<0, 20, 19> 27.59/18]
  # def >(other_move)
  #   (rock? && other_move.scissors?) ||
  #     (paper? && other_move.rock?) ||
  #     (scissors? && other_move.paper?) ||
  #     (rock? && other_move.lizard?) ||
  #     (lizard? && other_move.spock?) ||
  #     (spock? && other_move.scissors?) ||
  #     (scissors? && other_move.lizard?) ||
  #     (lizard? && other_move.paper?) ||
  #     (paper? && other_move.spock?) ||
  #     (spock? && other_move.rock?)
  # end

  # Metrics/AbcSize: Assignment Branch Condition size for > is too high. [<0, 15, 14> 20.52/18]
  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.lizard? || other_move.paper?))
  end

  # Original
  # Metrics/AbcSize: Assignment Branch Condition size for < is too high. [<0, 20, 19> 27.59/18]
  # def <(other_move)
  #   (scissors? && other_move.rock?) ||
  #     (rock? && other_move.paper?) ||
  #     (paper? && other_move.scissors?) ||
  #     (lizard? && other_move.rock?) ||
  #     (spock? && other_move.lizard?) ||
  #     (scissors? && other_move.spock?) ||
  #     (lizard? && other_move.scissors?) ||
  #     (paper? && other_move.lizard?) ||
  #     (spock? && other_move.paper?) ||
  #     (rock? && other_move.spock?)
  # end

  def to_s
    @value
  end
end

# Game Orchestration Engine
class RPSGame
  POINTS_TO_WIN = 3

  attr_accessor :human, :computer, :round_winner

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors! #{human.name}!"
    puts "Win #{POINTS_TO_WIN} points to be the GRAND WINNER!"
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

  def display_move_options
    puts "Scissors cuts Paper    | Paper covers Rock\n" \
         "Rock crushes Lizard    | Lizard poisons Spock\n" \
         "Spock smashes Scissors | Scissors decapitates Lizard\n" \
         "Lizard eats Paper      | Paper disproves Spock\n" \
         'Spock vaporizes Rock   | Rock crushes Scissors'
  end

  def display_round_winner(round_winner)
    case round_winner
    when human
      puts "#{human.name} won this round!"
    when computer
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def tally_scores(round_winner)
    if round_winner == human
      human.points += 1
    elsif round_winner == computer
      computer.points += 1
    end
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

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts 'Sorry, must be y or n.'
    end

    answer.downcase == 'y'
  end

  def reset_points
    human.points = 0
    computer.points = 0
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors, Rock, Lizard. Good bye!'
  end

  def a_single_round
    display_move_options
    human.choose
    computer.choose
    display_moves
    determine_round_winner
    display_round_winner(@round_winner)
    tally_scores(@round_winner)
    display_scores
  end

  def play
    display_welcome_message

    loop do
      a_single_round
      if reached_winning_points?
        display_grand_winner
        break unless play_again?
        reset_points
      end
    end

    display_goodbye_message
  end
end

RPSGame.new.play
