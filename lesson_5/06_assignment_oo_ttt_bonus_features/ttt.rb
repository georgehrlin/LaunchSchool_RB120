require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
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

  def immediate_win?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if two_identical_markers_and_one_unmarked?(squares)
    end
    false
  end

  def at_risk_square
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers_and_one_unmarked?(squares)
        line.each { |key| return key if @squares[key].unmarked? }
      end
    end
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def two_identical_markers_and_one_unmarked?(squares)
    markers = squares.map(&:marker)
    markers.uniq.size == 2 && squares.count(&:unmarked?) == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class Array
  def joinor(separator = ',', last_separator = 'or')
    if size <= 2
      join(" #{last_separator} ")
    else
      self[0...-1].join("#{separator} ") +
        "#{separator} #{last_separator} #{last}"
    end
  end
end

class TTTGame
  SCORE_TO_WIN = 5
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      single_set_of_rounds
      break unless play_again?
      reset_player_scores
      reset
      display_play_again_message
    end
  end

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

  def single_round
    display_board
    player_move
    display_result
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "Win #{SCORE_TO_WIN} games to be the winner!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.joinor}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.immediate_win? 
      board[board.at_risk_square] = computer.marker # Computer defends
    else
      board[board.unmarked_keys.sample] = computer.marker
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

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won this round!"
    when computer.marker
      puts "Computer won this round."
    else
      puts "It's a tie!"
    end
  end

  def update_player_scores
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_player_scores
    puts "You: #{human.score} vs. Computer: #{computer.score}"
  end

  def grand_winner?
    human.score == SCORE_TO_WIN || computer.score == SCORE_TO_WIN
  end

  def display_grand_winner
    clear
    if human.score == SCORE_TO_WIN
      puts "YOU ARE THE WINNER! ୧(๑•̀ヮ•́)૭ LET'S GO!!!"
    else
      puts 'Computer is the winner.'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def prompt_player_to_continue
    puts "Press Enter to continue."
    gets
  end

  def reset_player_scores
    human.score = 0
    computer.score = 0
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
