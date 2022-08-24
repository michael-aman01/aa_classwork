require_relative "tile.rb"
require 'colorize'

class Board
    attr_reader :grid
    def initialize
        @grid = self.from_file
    end

    def []=(pos,new_val)
        @grid[pos[0]][pos[1]] = Tile.new(new_val)
    end

    def from_file
        paths = ["./puzzles/sudoku1.txt"]
        f = File.open(paths[0]).read.split
        game_board = []
        (0...f.length).each do |i|
            row = f[i].chars.map {|elem| elem.to_i} #row in sudoku table
            tiles = row.map {|elem| Tile.new(elem)}
            game_board << tiles
        end
        return game_board
    end

    def render
        render_table = [] #holds print ready version of grid
        (0...@grid.length).each do |i|
            nested = []
            @grid[i].map do |elem|
                
                if elem.value == 0
                    nested << elem.value
                else
                    nested << elem.to_s  
                end
            end
            render_table << nested
        end
        puts "  #{(0...render_table.length).to_a.join("_").colorize(:red)}"
      
        (0...render_table.length).each do |j|
            puts "#{j.to_s.colorize(:red)} #{render_table[j].join("|")}"
        end
        return render_table
    end


    


end
p 
b = Board.new
