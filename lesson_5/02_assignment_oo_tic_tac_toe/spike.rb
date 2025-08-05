# Board
# Square
# Player
# - mark
# - play

class Board
  def initialize
    # we need some way to model the 3*3 grid. Maybe "squares"?
    # what data structure should we use?
    #   - arr/hsh of Square objects?
    #   - arr/hsh of strs or ints?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this sqaure's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (i.e., 'X' or 'O')
  end

  def mark
    
  end

  def play
    
  end
end

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      frist_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
