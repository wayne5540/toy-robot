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
        # Ignored
      end
    else
      # Ignored
    end
  end

  private

  def place(arguments)
    tokens = arguments.split(/,/)

    return if tokens.size != 3

    x = tokens[0].to_i
    y = tokens[1].to_i
    orientation = tokens[2].downcase.to_sym

    if @board.place!(x, y) && @robot.face!(orientation)
      nil
    else
      # Ignored
    end
  end

  def move
    return unless placed?

    new_x = @board.position[:x] + vector[:x]
    new_y = @board.position[:y] + vector[:y]
    if @board.place!(new_x, new_y)
      nil
    else
      # Ignore, out of boundary
    end
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
      # TODO: Raise error, should not happen.
    end
  end

  def placed?
    @board.placed? && !@robot.orientation.nil?
  end
end