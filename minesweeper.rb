require_relative "board"

class Minesweeper

    def initialize(size)
        @board = Board.new(size)
    end

end