class Board
  def immediate_win?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if two_identical_markers_and_one_unmarked?(squares)
    end
    false
  end

  def immediate_winner_marker
    winning_lines = find_winning_lines
    winning_markers = winning_lines_to_markers(winning_lines)

    if winning_markers.size > 1
      if winning_markers.any? do |markers|
         markers.include?(TTTGame::COMPUTER_MARKER)
      end
        TTTGame::COMPUTER_MARKER
      else
        TTTGame::HUMAN_MARKER
      end
    elsif winning_markers.size == 1
      winning_markers.first.each do |marker|
        return marker if winning_markers.first.count(marker) == 2
      end
    else
      nil
    end
  end

  def immediate_computer_loss?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if two_human_markers_and_one_unmarked?(squares)
    end
    false
  end

  def immediate_computer_win?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return true if two_computer_markers_and_one_unmarked?(squares)
    end
    false
  end

  def winning_square
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_computer_markers_and_one_unmarked?(squares)
        line.each { |key| return key if @squares[key].unmarked? }
      end
    end
  end

  def two_human_markers_and_one_unmarked?(squares)
    markers = squares.map(&:marker)
    markers.uniq.size == 2 &&
      markers.include?(TTTGame::HUMAN_MARKER) &&
      squares.count(&:unmarked?) == 1
  end

  def two_computer_markers_and_one_unmarked?(squares)
    markers = squares.map(&:marker)
    markers.uniq.size == 2 &&
      markers.include?(TTTGame::COMPUTER_MARKER) &&
      squares.count(&:unmarked?) == 1
  end
end