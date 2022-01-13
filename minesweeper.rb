require_relative "board"

class Minesweeper

    def initialize(size=9)
        @board = Board.new(size)
        @size = size
        @num_bombs = @size + 1
        @game_over == false
    end

    def play
        while @game_over == false
            puts "Enter pos (comma separated) followed by (space) R (for reveal) or F (for flag), ex: 1,1 R or 2,3 F"
            input = gets.chomp
            if input_valid?(input)

            end
        end
    end

    def input_valid?(input)
        comma_index = input.index(",")

    end

    def parse_input

    end

end

if __FILE__ == $0
    Minesweeper.new.play
end