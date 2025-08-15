require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def [](num)
    @squares[num]
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def empty?
    unmarked_keys.size == @squares.size
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!round_winning_marker
  end

  def round_winning_marker
    WINNING_LINES.each do |winning_line|
      squares = @squares.values_at(*winning_line)
      return squares.first.marker if three_same_markers?(squares)
    end

    nil
  end

  def immediate_win?
    !all_winning_lines.empty?
  end

  def at_risk_square
    winning_lines = all_winning_lines
    winning_markers = convert_lines_to_markers(winning_lines)

    if winning_lines.size > 1
      idx = index_of_markers_that_include_marker(winning_markers,
                                                 TTTGame::COMPUTER_MARKER)
      idx = (idx.nil? ? 0 : idx)
      square_num_of_unmarked(winning_lines[idx])
    else
      square_num_of_unmarked(winning_lines.first)
    end
  end

  private

  def all_winning_lines
    result = []
    WINNING_LINES.each do |winning_line|
      squares = @squares.values_at(*winning_line)
      result << winning_line if two_same_markers_and_one_unmarked?(squares)
    end

    result
  end

  def convert_lines_to_markers(lines)
    lines.map { |line| @squares.values_at(*line).map(&:marker) }
  end

  def index_of_markers_that_include_marker(markers, marker)
    markers.index { |set| set.include?(marker) }
  end

  def square_num_of_unmarked(line)
    line.each { |num| return num if @squares[num].unmarked? }
    nil
  end

  def three_same_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    markers.uniq.size == 1 && markers.size == 3
  end

  def two_same_markers_and_one_unmarked?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    markers.uniq.size == 1 && squares.count(&:unmarked?) == 1
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def marked?
    !unmarked?
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
  attr_accessor :score

  def initialize(name=nil, marker=nil)
    @name = name
    @marker = marker
    @score = 0
  end
end

class Human < Player
  def customize_name
    puts "What's your name?"
    puts '(Enter a name and press Enter.)'
    @name = prompt_player_name
    puts "Hi, #{@name}!"
    sleep(1.2)
    puts
  end

  def customize_marker
    puts 'Enter any single character to customize your marker for the game!'
    puts '(Enter one character and press Enter.)'
    puts '(If nothing is entered, your marker will default to X.)'
    custom_marker = prompt_player_marker
    @marker = custom_marker.empty? ? 'X' : custom_marker
    puts "Your marker is #{@marker}."
    puts
    sleep(1.2)
  end

  private

  def prompt_player_name
    loop do
      name = gets.chomp
      return name if !name.empty?
      puts 'Sorry, please enter a name. (And press Enter.)'
    end
  end

  def prompt_player_marker
    loop do
      custom_marker = gets.chomp
      return custom_marker if custom_marker.size <= 1
      puts 'Sorry. Your custom marker can only contain one character.'
    end
  end
end

class Computer < Player
  NAMES = ['R2D2', 'WALL-E', 'Chappie']
  MARKERS = { 'R2D2' => 'Ɔ', 'WALL-E' => 'Џ', 'Chappie' => 'ш' }

  def initialize
    name = NAMES.sample
    super(name, MARKERS[name])
  end
end

class Array
  def joinor(separator=',', last_separator='or')
    if size <= 2
      join(" #{last_separator} ")
    else
      self[0...-1].join("#{separator} ") +
        "#{separator} #{last_separator} #{last}"
    end
  end
end

class TTTGame
  SCORE_TO_WIN = 2
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @first_to_move = FIRST_TO_MOVE
    @current_marker = nil
  end

  def play
    clear
    display_welcome_message
    initialize_player_human
    display_computer_info
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      select_first_to_move
      display_first_to_move
      display_set_start_message
      single_set_of_rounds
      break unless play_again?
      reset_player_scores
      reset
      display_play_again_message
    end
  end

  # rubocop:disable Metrics/MethodLength
  def single_set_of_rounds
    loop do
      single_round
      update_player_scores
      display_player_scores
      prompt_player_to_continue
      if grand_winner?
        display_grand_winner
        break
      end
      reset
    end
  end
  # rubocop:enable Metrics/MethodLength

  def single_round
    clear
    display_board if human_first?
    player_move
    display_result
  end

  def clear
    system 'clear'
  end

  def initialize_player_human
    human.customize_name
    human.customize_marker
  end

  def display_computer_info
    puts "Your opponent is: #{computer.name}."
    puts
    sleep(1.2)
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts "Win #{SCORE_TO_WIN} games to be the winner!"
    puts ''
    sleep(1.2)
  end

  def select_first_to_move
    if select_first_to_move?
      player_decision = player_select_first_to_move
      specify_first_to_move_given_player_selection(player_decision)
    else
      computer_select_first_to_move
    end
  end

  def select_first_to_move?
    puts 'Do you want to choose who goes first?'
    puts '(If not, computer will chose.)'
    puts 'Enter y: yes, or n: no. (And press Enter.)'
    decision = nil

    loop do
      decision = gets.chomp.downcase
      break if %w(y n).include?(decision)
      puts 'Sorry, your input must be y or n.'
    end

    decision == 'y'
  end

  def player_select_first_to_move
    puts 'Enter 1: you go first, or 2: computer goes first. (And press Enter.)'
    decision = nil

    loop do
      decision = gets.chomp
      break if %w(1 2).include?(decision)
      puts "Sorry, your input must be 1 or 2."
    end

    decision
  end

  def specify_first_to_move_given_player_selection(player_decision)
    case player_decision
    when '1' then @first_to_move = HUMAN_MARKER
    when '2' then @first_to_move = COMPUTER_MARKER
    end

    @current_marker = @first_to_move
  end

  def computer_select_first_to_move
    @first_to_move = [HUMAN_MARKER, COMPUTER_MARKER].sample
    @current_marker = @first_to_move
  end

  def display_first_to_move
    case @first_to_move
    when HUMAN_MARKER
      puts 'You are going first!'
    when COMPUTER_MARKER
      puts 'Computer is going first!'
    end
    puts
    sleep(1.2)
  end

  def display_set_start_message
    puts "Game is starting..."
    sleep(1.2)
    puts "Get ready!"
    sleep(1.5)
  end

  def display_board
    puts "You're #{human.marker}. Computer is #{computer.marker}"
    puts ''
    board.draw
    puts ''
  end

  def human_first?
    @first_to_move == HUMAN_MARKER
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.joinor}): "
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, input must be an available empty square."
    end

    board[square] = human.marker
  end

  # rubocop:disable Metrics/AbcSize
  def computer_moves
    if board.immediate_win?
      board[board.at_risk_square] = computer.marker
    elsif board[5].unmarked? && !board.empty?
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end
  # rubocop:enable Metrics/AbcSize

  def display_result
    clear_screen_and_display_board

    case board.round_winning_marker
    when human.marker
      puts 'You won this round!'
    when computer.marker
      puts 'Computer won this round.'
    else
      puts "It's a tie!"
    end
  end

  def update_player_scores
    case board.round_winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_player_scores
    puts "You: #{human.score} vs. Computer: #{computer.score}"
  end

  def prompt_player_to_continue
    puts 'Press Enter to continue.'
    gets
  end

  def grand_winner?
    human.score == SCORE_TO_WIN || computer.score == SCORE_TO_WIN
  end

  def display_grand_winner
    clear
    if human.score == SCORE_TO_WIN
      puts "You are the winner! ୧(๑•̀ヮ•́)૭ CONGRATULATIONS!!!"
    else
      puts 'Computer is the winner... (ಥ﹏ಥ)'
    end
    sleep(1.2)
    puts
  end

  def play_again?
    answer = nil

    loop do
      puts 'Would you like to play again?'
      puts 'Enter: y for yes, or n for no. (And press Enter.)'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts 'Sorry, your input must be y or n.'
    end

    answer == 'y'
  end

  def reset_player_scores
    human.score = 0
    computer.score = 0
  end

  def reset
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
    sleep(1.2)
  end

  def display_goodbye_message
    puts 'Thank you for playing Tic Tac Toe. Goodbye!'
  end
end

game = TTTGame.new
game.play
