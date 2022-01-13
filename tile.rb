class Tile

    attr_accessor :bomb, :revealed, :flagged

    def initialize(board, row, col)
        @bomb = false
        @revealed = false
        @flagged = false
        @board = board
        @row = row
        @col = col
    end

    def inspect
        "bomb = #{@bomb}, revealed = #{@revealed}, flagged = #{@flagged}, pos = #{@row},#{@col}"
    end

    def reveal 
        #bomb 
    end

    def neighbors #lists all neighbors (up to 8)
        start_row = @row -1
        end_row = @row + 1
        start_col = @col - 1
        end_col = @col + 1
        # debugger
        neighbors_arr = []
        (start_row..end_row).each do |row|
            if row >= 0 && row < @board.size #skip rows out of grid
                (start_col..end_col).each do |col|
                    if col >= 0 && row < @board.size #skip col out of grid
                        if !(row == @row && col == @col) #skip current tile
                            neighbors_arr << @board[row][col]
                        end
                    end
                end
            end
        end
        neighbors_arr
    end

    def neighbor_bomb_count
        neighbors_arr = self.neighbors
        neighbors_arr.count { |tile| tile.bomb == true }
    end

end