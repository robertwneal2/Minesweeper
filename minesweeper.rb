require_relative "board"
require "byebug"

class Minesweeper

    def initialize(size=9)
        @board = Board.new(size)
        @size = size
        @num_bombs = @size + 1
        @game_over = false
    end

    def play
        # debugger
        while @game_over == false
            puts "Enter pos (comma separated) followed by (space) R (for reveal) or F (for flag), ex: 1,1 R or 2,3 F"
            input = gets.chomp
            if input_valid?(input)

            end
        end
    end

    def input_valid?(input)
        # debugger
        nums = "0123456789"

        if input.length < 5
            puts "Input length too short, did you forget something?"
            return false
        end

        comma_index = input.index(",")
        if comma_index == nil
            puts "No comma!"
            return false
        end

        space_index = input.index(" ")
        if space_index == nil
            puts "No space!"
            return false
        end

        row = input[0...comma_index]
        col = input[comma_index+1...space_index]

        row.each_char do |char|
            if !nums.include?(char)
                puts "Invalid row number"
                return false
            end
        end
        row = row.to_i
        if row < 0 or row >= @size
            puts "Invalid row number"
            return false
        end

        col.each_char do |char|
            if !nums.include?(char)
                puts "Invalid col number"
                return false
            end
        end
        col = col.to_i
        if row < 0 or row >= @size
            puts "Invalid col number"
            return false
        end

        move_options = "rRfF"
        move = input[space_index+1..-1]
        if move.length != 1 || !move_options.include?(move)
            puts "Invalid move, must be R or F only"
            return false
        end

        true
    end

    def parse_input

    end

end

if __FILE__ == $0
    Minesweeper.new.play
end