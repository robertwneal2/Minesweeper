require_relative "board"
require "byebug"

class Minesweeper

    def initialize(size=9)
        if !size.is_a?(Integer) || size < 2
            raise "Size must be a number more than 1"
        end
        @board = Board.new(size)
        @size = size
        @num_bombs = @size + 1
        @no_bomb = true
    end

    def play
        @board.populate_grid
        while game_over?(@no_bomb) == false
            system("clear")
            @board.render
            puts "Enter pos (comma separated) followed by (space) r (for reveal) or f (for flag), ex: 1,1 r or 2,3 f"
            input = gets.chomp
            if input_valid?(input)
                parsed_input = parse_input(input)
                pos = parsed_input[0]
                move = parsed_input[1]
                if move == "r"
                    @no_bomb = @board.reveal(pos)
                elsif move == "f"
                    @board.flag(pos)
                end

                if @no_bomb == false #render "X" on board when lose
                    system("clear")
                    @board.render
                end

            else
                sleep(2) #sleep to see input error message
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

    def parse_input(input)
        comma_index = input.index(",")
        space_index = input.index(" ")
        row = input[0...comma_index].to_i
        col = input[comma_index+1...space_index].to_i
        move = input[-1]
        [[row,col],move.downcase]
    end

    def game_over?(no_bomb)
        if no_bomb == false
            puts "Bomb hit, you lose!"
            return true
        else
            revealed_count = @board.revealed_count
            if revealed_count == @size*@size - @num_bombs
                puts "You win!"
                return true
            end
        end
        false
    end

end

if __FILE__ == $0
    Minesweeper.new(2).play
end