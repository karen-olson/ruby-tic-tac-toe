class NumberValidator
  def valid?(input, range)
    integer?(input) && range.include?(Integer(input))
  end

  private

  def integer?(input)
    number = input.to_i
    number.to_s == input
  end
end
