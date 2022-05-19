require 'pry'

class Board
  attr_accessor :values

  def initialize
    @values = (1..9).to_a
  end

  def get_space(row, column)
    index = (row * 3) + column
    values[index]
  end

  def mark_space(token, space)
    if valid_number?(space)
      values[space - 1] = token
    else
      # what to do if there's incorrect input?
      # who should be responsible for 
      #     setting an error state in game?
      #     displaying an error message to the user?
      #     prompting for more input?
      # return
    end
  end

  private 

  def valid_number?(space)
    space.is_a?(Integer) && (1..9).include?(space)
  end

  # def open?(space)
  #   values[space - 1].is_a?(Integer)
  # end
end
