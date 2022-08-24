require_relative "board.rb"

class Game 

  attr_reader :game_board

  def initialize
    b = Board.new
    b.populate
    @game_board = b.grid 
    @guesses = []
    @tries = 0
    @found = 0
    @possible = (b.size * b.size) 
  end

  def get_coordinates
    
    p "enter coordinates (two values, separated by a space) between 0 and #{@game_board.length - 1}"
    coordinates = gets.chomp.split
    coordinates.map! {|ele| ele.to_i}

    if !(0...@game_board.length).to_a.include?(coordinates[0]) || !(0...@game_board.length).to_a.include?(coordinates[1])
      raise ArgumentError.new 'invalid coordinates!'
    else
      return coordinates
    end
  end

  def run_game 
    p @game_board
    guessed_coordinates = []
    self.display_game_board
    while @guesses.length < 2
      coordinates = self.get_coordinates
      if guessed_coordinates.include?(coordinates)
        p 'coordinates must be unique!'
      else
        self.display_game_board(coordinates)
        guessed_coordinates << coordinates
        @guesses << @game_board[coordinates[0]][coordinates[1]]
      end
    end

    @tries += 1
    if @guesses[0].token == @guesses[1].token
      @found += 1
      @guesses[0].reveal
      @guesses[1].reveal
    end

    if @found == @possible
      p 'you win!'
    end
    
  end

  def display_game_board(coordinates=nil)
    if coordinates != nil
      @game_board[coordinates[0]][coordinates[1]].reveal
    end
    puts
    puts "  #{(0...@game_board.length).to_a.join(" ")}"
    puts
    (0...@game_board.length).each do |i|
      str_arr = @game_board[i].map {|elem| elem.face_value}.join(" ")
      puts "#{i} #{str_arr}"
    end
  end
end

game1 = Game.new
game1.run_game


