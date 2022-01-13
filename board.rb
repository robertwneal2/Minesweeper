require_relative "tile"
require "colorize"

class Board

    attr_reader :grid #remove after finished

    def initialize(size, num_bombs)
        @size = size
        @grid = Array.new(@size) {Array.new}
        @num_bombs = num_bombs
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
        puts "  #{(0...@size).to_a.join(" ")}".colorize(:blue)
        @grid.each_with_index do |row, i|
            row_str = "#{i}".colorize(:blue)
            row.each do |tile|
                reveal = tile.revealed
                flagged = tile.flagged
                if flagged == true
                    new_char = "F".colorize(:magenta)
                elsif reveal == 0 #no bombs
                    new_char = "_"
                elsif reveal #anything but nil or false
                    if reveal == "X"
                        color = :red
                    else
                        color = :green
                    end
                    new_char = "#{reveal}".colorize(color) #num bombs
                else
                    new_char = "*".colorize(:yellow) #not revealed
                end
                row_str += " " + new_char
            end
            puts row_str
        end
        #prints the board
    end

    def reveal(pos)
        row, col = pos
        tile = @grid[row][col]
        tile.reveal
    end

    def flag(pos)
        row, col = pos
        tile = @grid[row][col]
        tile.flag
    end

    def revealed_count
        count = 0
        @grid.each do |row|
            row.each do |tile|
                if tile.revealed != false
                    count += 1
                end
            end
        end
        count
    end

end

if __FILE__ == $0
    # p String.colors
    p String.color_samples
end