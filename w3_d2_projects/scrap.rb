
require_relative "card.rb"
class Board

  attr_reader :size, :grid

  def initialize
    @size = self.get_size
    @grid = Array.new(@size){Array.new(@size)}
  end


  def get_size
    p "Enter an even value for size: "
    size = gets.chomp.to_i
    if size%2 != 0
      raise ArgumentError.new "Enter an even value for size"
    else
      return size
    end
  end


  def generate_random_pairs
    alphabet = (97..122).to_a.map {|letter| letter.chr.upcase}
    size = @size
    element_count = size * size
    pair_count = element_count/2
    pairs = []
    i = 0
    while i < pair_count
      while true
        rand_letter = alphabet.sample
        if pairs.include?(rand_letter) == true
          next
        else
          pairs << rand_letter
          break
        end
      end
      i += 1
    end
    pairs = pairs * 2
    used_indices = []
    i = 0
    while i < pairs.length
      while true
        rand_int = rand(0...pairs.length)
        if used_indices.include?(rand_int)
          next
        else
          used_indices << rand_int
          break
        end
      end
      i += 1
    end
    random_pairs = used_indices.map {|i| pairs[i]}
    return random_pairs
  end
  
  def group_pairs
    pairs = self.generate_random_pairs
    element_count = pairs.length
    size = @size #change later
    j = 0
    matrix = []
    while j < element_count
      i = 0
      nested = []
      while i < size
        nested << pairs[i..-1][j]
        i += 1
      end
      matrix << nested
      j += size
    end
    return matrix
  end

  def populate
    matrix = self.group_pairs 
      (0...@grid.length).each do |idx1|
        (0...@grid.length).each do |idx2|
          @grid[idx1][idx2] = Card.new(matrix[idx1][idx2])
        end
      end
  end

end





#card has value, status 
# [card_1,card_2.....] --> BOARD
# games class asks for coordinates 0,0
# return first value from board ---> Board[0][0].value

