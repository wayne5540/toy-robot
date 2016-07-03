require_relative "robot"
require_relative "board"

class Simulator
  VALID_ACTIONS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]

  def initialize
    @robot = Robot.new
    @board = Board.new
  end

  def execute(command)
    tokens = command.split(/\s+/)
    action = tokens.first
    arguments = tokens.last

    if VALID_ACTIONS.include?(action)
      dispatch_command(action, arguments)
    else
      "Ignored - invalid command"
    end
  end

  private

  def dispatch_command(action, arguments)
    case action
    when "PLACE"
      place(arguments)
    when "MOVE"
      move
    when "LEFT"
      left
    when "RIGHT"
      right
    when "REPORT"
      report
    else
      "Internal Error - command not found"
    end
  end

  def place(arguments)
    tokens = arguments.split(/,/)

    return "Ignored - PLACE requires 3 arguments. ex: PLACE 1,2,NORTH" if tokens.size != 3

    begin
      x = Integer(tokens[0])
      y = Integer(tokens[1])
    rescue ArgumentError
      return "Ignored - coordinate should be a number"
    end
    orientation = tokens[2].downcase.to_sym

    if @board.place!(x, y)
      if @robot.face!(orientation)
        nil
      else
        "Ignored - invalid orientation"
      end
    else
      "Ignored - out of boundary"
    end
  end

  def move
    return unless placed?

    new_x = @board.position[:x] + vector[:x]
    new_y = @board.position[:y] + vector[:y]

    @board.place!(new_x, new_y)

    nil # prevent to print on console
  end

  def left
    @robot.turn_left! if placed?

    nil # prevent to print on console
  end

  def right
    @robot.turn_right! if placed?

    nil # prevent to print on console
  end

  def report
    "#{@board.report_position},#{@robot.report_orientation}" if placed?
  end

  def vector
    case @robot.orientation
    when :north
      { x: 0, y: 1 }
    when :south
      { x: 0, y: -1 }
    when :east
      { x: 1, y: 0 }
    when :west
      { x: -1, y: 0 }
    else
      "Internal Error - invalid orientation"
    end
  end

  def placed?
    @board.placed? && !@robot.orientation.nil?
  end
end