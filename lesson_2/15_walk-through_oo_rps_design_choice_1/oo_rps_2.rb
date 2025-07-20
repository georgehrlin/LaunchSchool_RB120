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
      break if ['rock', 'paper', 'scissors'].include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
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

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
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
Is this design, with Human and Computer sub-classes, better? Why, or why not?

A: Conceptually, this new design with Human and Computer subclasses is better.
It makes intuitive sense that Human and Computer are subclasses of Player in
the context of this game. Moreover, it also makes sense that set_name and
choose are behaviours that an object of Human or Computer can act out. In my
opinion, a 'human' and a 'computer' is different enough (e.g., different
implementations of set_name and choose) in this game that they warrant each of
their own class. Also, the new version's code is noticeably more readable
without the conditional to check if an instance variable that stands for a
player is human or not.

Q: What is the primary improvement of this new design?

A: Conceptually this new design is much clearer with 'human' and 'computer'
having their own class that inherit from the Player class. This leads to better
differentiation of the similar behaviours (though with different
implementations) between a 'human' and a 'computer'. This clearer structure is
helpful for management and maintainability of the code.

LSBot: Removal of conditionals in the Player class makes the code more
object-oriented and easier to extend.

Q: What is the primary drawback of this new design?

A1: A case can be made that now there is no need for the Player class, and that
the entirety of Player has become redundant code. Having a Player class still
makes conceptual sense, but in practicality there is so little to the class
that its implementation might as well just be split into Human and Computer.

A2: Now that a 'human' and a 'computer' are objects of their distinct subclass,
there is some added complexity of having to make sure that they behave the
same, in the sense that the behaviours align with what the rest or the program
expects.
=end
