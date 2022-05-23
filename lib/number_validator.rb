class NumberValidator
  def valid?(input, range)
    integer?(input) && range.include?(Integer(input))
  end

  private

  def integer?(input)
    Integer(input)
    true
  rescue ArgumentError
    false
  end
end
