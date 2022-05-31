class Player
  # Should this be a value object?
  # Should it have a select method?

  attr_reader :marker

  def initialize(marker:)
    @marker = marker
  end
end
