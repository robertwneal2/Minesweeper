class Tile

    attr_accessor :bomb, :revealed, :flagged

    def initialize
        @bomb = false
        @revealed = false
        @flagged = false
    end

end