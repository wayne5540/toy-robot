class Board
  attr_accessor :position

  def place(x, y)
    self.position = { x: x, y: y } if valid_position?(x, y)
  end

  def placed?
    !position.nil?
  end

  def report_position
    "#{position[:x]},#{position[:y]}"
  end

  private

  def valid_position?(x, y)
    x >=0 && x <= 4 && y >=0 && y <= 4
  end
end