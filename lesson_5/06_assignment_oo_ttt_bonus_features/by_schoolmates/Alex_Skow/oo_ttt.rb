require 'yaml'
DISPLAYS = YAML.load_file('ttt.yml')

module Readable
  def joinor(choices, punctuation = ', ', delimiter = 'or')
    readable_choices = choices.map do |number|
      if choices.size == 1
        number

      elsif choices.last == number
        "#{delimiter} #{number}"

      else
        "#{number}#{punctuation}"
      end
    end
    readable_choices.join
  end
end

class Board
  WINNING_LINES = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ]

  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each do |key|
      squares[key] = Square.new
    end
  end

  def full?
    empty_squares.empty?
  end

  def odd_number_remaining?
    empty_squares.size.odd?
  end

  def line_to_markers(line)
    line.map { |key| squares[key].marker }
  end

  def two_in_a_row?(line)
    markers = line_to_markers(line)
    markers.uniq.size == 2 && markers.count(Square::INITIAL_MARKER) == 1
  end

  def find_open_marker(line)
    line.each do |key|
      return key if squares[key] == Square::INITIAL_MARKER
    end
  end

  def two_computer_marks?(line, marker)
    line.count { |key| squares[key] == marker } == 2
  end

  def three_identical_markers?(line)
    markers = line_to_markers(line)
    markers.uniq.size == 1 && !markers.include?(Square::INITIAL_MARKER)
  end

  def get_winning_marker(line)
    first_square = line[0]
    squares[first_square].marker
  end

  def available?(move)
    squares[move].unmarked?
  end

  def empty_squares
    squares.keys.select { |key| available?(key) }
  end

  def []=(move, new_marker)
    squares[move].update_marker(new_marker)
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts ""
    puts "      |         |"
    puts "  #{squares[1]}   |    #{squares[2]}    |  #{squares[3]}"
    puts "      |         |"
    puts "------+---------+------"
    puts "      |         |"
    puts "  #{squares[4]}   |    #{squares[5]}    |  #{squares[6]}"
    puts "      |         |"
    puts "------+---------+------"
    puts "      |         |"
    puts "  #{squares[7]}   |    #{squares[8]}    |  #{squares[9]}"
    puts "      |         |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize
end

class Square
  INITIAL_MARKER = ' '
  X_MARKER = 'X'
  O_MARKER = 'O'

  attr_reader :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    marker
  end

  def update_marker(new_mark)
    self.marker = new_mark
  end

  def unmarked?
    self == INITIAL_MARKER
  end

  def ==(some_value)
    marker == some_value
  end

  private

  attr_writer :marker
end

class Player
  attr_accessor :name
  attr_reader :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
    @name = set_name
  end

  def win_point
    self.score += 1
  end

  def reset_score
    self.score = 0
  end

  def to_s
    name
  end

  private

  attr_writer :score
end

class Human < Player
  include Readable

  def set_name
    name = nil

    puts DISPLAYS['name_question']
    loop do
      name = gets.chomp.capitalize.strip

      break unless name == ''
      puts DISPLAYS['name_error']
    end

    self.name = name
  end

  def move(board)
    choice = nil
    puts "#{DISPLAYS['choose_square']} (#{joinor(board.empty_squares)})"

    loop do
      choice = gets.chomp.to_i

      break if (1..9).include?(choice) && board.available?(choice)
      puts DISPLAYS['square_error']
    end
    choice
  end
end

class Computer < Player
  def set_name
    self.name = ['Jeffrey', 'C-3PO', 'That One Guy'].sample
  end

  def move(board)
    possible_moves = board.empty_squares
    move = possible_moves.sample
    return 5 if possible_moves.include?(5)

    Board::WINNING_LINES.each do |line|
      smart_move = board.find_open_marker(line)

      move_is_possible = possible_moves.include?(smart_move)
      two_computer_marks = board.two_computer_marks?(line, marker)
      two_in_a_row = board.two_in_a_row?(line)

      if (two_computer_marks || two_in_a_row) && move_is_possible
        return smart_move
      end
    end
    move
  end
end

module GameDisplays
  def clear
    system "clear"
  end

  def display_welcome_message
    puts DISPLAYS['welcome']
    sleep 1.5
  end

  def display_name_reaction
    clear
    puts format(DISPLAYS['name_reaction'], human, computer)
    sleep 2
  end

  def display_rules_question
    puts DISPLAYS['rules_question']
  end

  def display_teaching_board
    puts ""
    puts "      |           |       "
    puts "  1   |     2     |   3   "
    puts "      |           |       "
    puts "------+-----------+------ "
    puts "      |           |       "
    puts "  4   |     5     |   6   "
    puts "      |           |       "
    puts "------+-----------+------ "
    puts "      |           |       "
    puts "  7   |     8     |   9   "
    puts "      |           |       "
    puts ""
  end

  def display_rules
    clear
    puts DISPLAYS['rules']
    display_teaching_board
    press_enter
  end

  def display_goodbye_message
    clear
    puts DISPLAYS['goodbye']
  end

  def format_board_info(human_data, computer_data)
    " #{human}: #{human_data}    |    #{computer}: #{computer_data}"
  end

  def display_score
    puts format_board_info(human.score, computer.score)
    puts ""
  end

  def display_board
    clear
    puts format_board_info(human.marker, computer.marker)
    board.draw
    display_score
  end

  def display_result
    case determine_winning_marker
    when human.marker
      puts DISPLAYS['human_won']

    when computer.marker
      puts format(DISPLAYS['comp_won'], computer.name)

    else
      puts DISPLAYS['tie']
    end
    sleep 2
  end

  def display_grand_winner(player)
    if player == :human
      puts format(DISPLAYS['human_grand_winner'], human)

    else
      puts format(DISPLAYS['comp_grand_winner'], computer)
    end
  end

  def display_play_again
    puts DISPLAYS['play_again_question']
  end
end

module GamePrompts
  def yes_or_no
    choice = nil

    loop do
      choice = gets.chomp.upcase.delete(' ')

      break if choice.start_with?('Y') || choice.start_with?('N')
      puts DISPLAYS['yes_no_error']
    end
    choice
  end

  def press_enter
    puts DISPLAYS['enter']
    gets.chomp
  end
end

class TTTGame
  WINNING_SCORE = 3

  attr_accessor :board
  attr_reader :human, :computer

  include GameDisplays
  include GamePrompts

  def initialize
    display_welcome_message
    @human = Human.new(Square::X_MARKER)
    @computer = Computer.new(Square::O_MARKER)
    display_name_reaction
  end

  def see_rules?
    display_rules_question
    yes_or_no.start_with?('Y')
  end

  def set_board
    self.board = Board.new
  end

  def someone_won?
    !!determine_winning_marker
  end

  def determine_winning_marker
    Board::WINNING_LINES.each do |line|
      if board.three_identical_markers?(line)
        return board.get_winning_marker(line)
      end
    end
    nil
  end

  def calculate_score
    case determine_winning_marker
    when human.marker then human.win_point
    when computer.marker then computer.win_point
    end
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def determine_grand_winner
    if human.score == WINNING_SCORE
      display_grand_winner(:human)

    elsif computer.score == WINNING_SCORE
      display_grand_winner(:computer)
    end
  end

  def reset_scores
    human.reset_score
    computer.reset_score
  end

  # make it dryer by just using player local var

  def execute_moves(player)
    player_move = player.move(board)
    board[player_move] = player.marker
  end

  def play_round
    loop do
      if board.odd_number_remaining?
        execute_moves(human)
      else
        execute_moves(computer)
      end

      display_board
      break if someone_won? || board.full?
    end
  end

  def end_round
    display_result
    calculate_score
    display_board
  end

  def end_game
    determine_grand_winner
    reset_scores
  end

  def play_again?
    display_play_again
    yes_or_no.start_with?('Y')
  end

  def play
    display_rules if see_rules?

    loop do
      set_board

      display_board
      play_round
      end_round
      end_game if grand_winner?

      break unless play_again?
    end
    display_goodbye_message
  end
end

TTTGame.new.play
