require_relative "tile"

class Board

    def initialize
        @size = 9
        @grid = Array.new(@size) {Array.new}
        @num_bombs = @size + 1
    end

    def populate_grid
        @grid.each do |row|
            @size.times { row << Tile.new }
        end

        count = 0
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

end