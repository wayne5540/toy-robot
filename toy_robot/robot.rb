class Robot
  attr_accessor :orientation

  def face!(orientation)
    if [:north, :south, :east, :west].include?(orientation)
      self.orientation = orientation
    else
      false
    end
  end

  def turn_left!
    self.orientation = left
  end

  def turn_right!
    self.orientation = right
  end

  def report_orientation
    orientation.to_s.upcase
  end

  private

  def left
    { north: :west, west: :south, south: :east, east: :north }[orientation]
  end

  def right
    { north: :east, east: :south, south: :west, west: :north }[orientation]
  end

end
