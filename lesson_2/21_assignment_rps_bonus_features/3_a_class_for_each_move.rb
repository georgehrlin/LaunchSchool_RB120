# Modified from 2_lizard_n_spock.rb
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
    move_options = [Rock, Paper, Scissors, Lizard, Spock]
    move_options_strs = move_options.map(&:to_s)
    choice = nil
    loop do
      puts 'Please choose rock, paper, scissors, spock, or lizard:'
      choice = gets.chomp.capitalize
      break if move_options_strs.include?(choice)
      puts 'Sorry, invalid choice.'
    end
    self.move = move_options[move_options_strs.index(choice)].new
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    move_options = [Rock, Paper, Scissors, Lizard, Spock]
    self.move = move_options.sample.new
  end
end

class Move
  def rock?
    instance_of?(Rock)
  end

  def paper?
    instance_of?(Paper)
  end

  def scissors?
    instance_of?(Scissors)
  end

  def lizard?
    instance_of?(Lizard)
  end

  def spock?
    instance_of?(Spock)
  end

  def to_s
    self.class.to_s.downcase
  end

  # Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  # Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.lizard? || other_move.paper?))
  end
end

class Rock < Move; end

class Paper < Move; end

class Scissors < Move; end

class Lizard < Move; end

class Spock < Move; end

# Game Orchestration Engine
class RPSGame
  POINTS_TO_WIN = 2

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

=begin
Q: After you're done, can you talk about whether this was a good design
decision? What are the pros/cons?

A: Given my implementation of this requirement and the current rules of the
game, I think this was a bad design decision. I'd say otherwise if we needed to
increase the program's expandability for new rules that might be added to each
move, but for how the game is now, creating those five new 'move' classes do
not add anything meaningful to the program. This is reflected in their empty
bodies.

Pros:
- More expandability for all the moves in case new features and interactions
  will be added to them

Cons:
- At least as far as my implementation goes, certain parts of the program
  became more complicated and less readable
  - Selecting one of the 'move' classes and storing an instance of it to @move
  - The implementation of the five Move instance methods that check for the
    identity of the 'move' became slightly more complicated
- As far as my implementation goes, the program now havs five completely empty
  classes
=end
