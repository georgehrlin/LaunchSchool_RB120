class Move
  VALUES = ['rock', 'paper', 'scissors']

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

  def >(other_move)
    if rock?
      return true if other_move.scissors?
      return false
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end
  end

  def <(other_move)
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
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

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return true if answer == 'y'
    return false
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
      display_goodbye_message
  end
end

RPSGame.new.play

=begin
Q: Compare this design with the one in the previous assignment.
What is the primary improvement of this new design?

A: This new design tremendously simplified the implementation of 
RPSGame#display_winner, as that was the original intention of this new deisng.

Making the 'moves' of the game concrete objects of their own class also brought
more conceptual clarity and expandability to 'moves' (e.g., pontential move
'moves').

Q: What is the primary drawback of this new design?

A: The reduced complexity of RPSGame#display_winner unfortunately came with the
cost of 40+ more lines of code in the new design than the old.

LSBot: Having more classes and methods means that the program is more difficult
to navigate and understand.
=end

=begin
NOTES

The biggest takeaway from the two design refactorings is that, when it comes to
object-oriented design, there is always a tradeoff between flexible code and
indirection. On one hand, we can have all the code in one place, but then we
lose flexibility. On the other hand, we can refactor the code for increased
flexibility and maintainability. However, the tradeoff is increased
indirection, which means that you have to dig deeper to fully understand what
is happening.

Put another way, the more flexible your code, the more indirection you'll
introduce by way of more classes. There's likely an optimal tradeoff on that
spectrum for your application somewhere, but that place likely changes as your
application matures. This is the source of never-ending debate and discussion
in the software development field, but it really comes down to that tradeoff.
This is where the "art" of programming comes in.
=end
