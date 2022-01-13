require_relative "tile"
require "byebug"

class Board

    attr_reader :grid #remove after finished

    def initialize
        @size = 9
        @grid = Array.new(@size) {Array.new}
        @num_bombs = @size + 1
    end

    def populate_grid
        @grid.each_with_index do |row, row_index| #empty tiles
            (0..@size-1).each do |col_index|
                tile = Tile.new(@grid, row_index, col_index)
                row << tile
            end
        end

        count = 0 #add bombs to tiles
        while count < @num_bombs
            rand_row = rand(@size)
            rand_col = rand(@size)
            tile = @grid[rand_row][rand_col]
            if tile.bomb == false
                tile.bomb = true
                count += 1
            end
        end
    end

    def render
        #prints the board
    end

end

if __FILE__ == $0
    board1 = Board.new
    board1.populate_grid
    p board1.grid[1][1].neighbor_bomb_count
end