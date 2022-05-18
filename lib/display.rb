class Display
  def present(board_values)
    <<~BOARD
       #{board_values[0]} | #{board_values[1]} | #{board_values[2]}
      ---+---+---
       #{board_values[3]} | #{board_values[4]} | #{board_values[5]}
      ---+---+---
       #{board_values[6]} | #{board_values[7]} | #{board_values[8]}
    BOARD
  end
end
