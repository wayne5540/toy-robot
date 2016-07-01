class Board
  def place(x, y)
    @position = {x: x, y: y} if valid_position?(x, y)
  end

  def placed?
    @position != nil
  end

  def position
    @position
  end

  def valid_position?(x, y)
    x >=0 && x <= 4 && y >=0 && y <= 4
  end  
end