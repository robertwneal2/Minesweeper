require_relative "board"
require "byebug"
require "yaml"

class Minesweeper

    def initialize(size = 9,num_bombs = 10)
        if !size.is_a?(Integer) || size < 2
            raise "Size must be a number more than 1"
        end
        @size = size
        @num_bombs = num_bombs
        @board = Board.new(@size, @num_bombs)
        @no_bomb = true
        @game_start = false
    end

    def play
        if @game_start == false
            @board.populate_grid
            @game_start = true
        end
        while game_over?(@no_bomb) == false
            system("clear")
            @board.render
            puts "Enter pos (comma separated) followed by (space) r (for reveal) or f (for flag), ex: '1,1 r' or '2,3 f'. May also enter 'save', 'load', or 'exit'"
            input = gets.chomp
            if input.downcase == "save"
                save_game
                break
            elsif input.downcase == "load"
                load_game
                break
            elsif input.downcase == "exit"
                system("clear")
                puts "Thanks for playing!"
                break
            elsif input_valid?(input)
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
                system("clear")
                @board.render
                puts "You win!"
                return true
            end
        end
        false
    end

    def save_game
        save_file = self.to_yaml
        puts "Enter game save name, ex: 'game 1'"
        save_file_name = gets.chomp
        File.open("save_games/#{save_file_name}.yml", "w") { |file| file.write(save_file) }
        system("clear")
        puts "Start a new game? Enter 'y' for a new game, 'load' to load a previous game, or anything else to stop playing"
        new_game = gets.chomp
        if new_game.downcase == "y"
            Minesweeper.new.play
        elsif new_game.downcase == "load"
            load_game
        else
            system("clear")
            puts "Thanks for playing!"
        end
    end

    def load_game
        system("clear")
        puts "Enter game save name to load, ex: 'game 1'"
        load_file_name = gets.chomp
        #check if file exists
        loaded_game = YAML.load(File.read("save_games/#{load_file_name.downcase}.yml"))
        loaded_game.play
    end

end

if __FILE__ == $0
    Minesweeper.new(9, 10).play
    puts "testing"
end