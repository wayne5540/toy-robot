
require "pry"
require_relative "board"

class Robot
  VALID_ACTIONS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]

  def initialize
    @board = Board.new
  end

  def execute(command)

    # TODO: check if command is empty
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
        puts "Command ignored"
      end
    else
      puts "Command ignored"
    end
  end

  def report
    puts "==========OUTPUT============"
    puts "Position: #{@board.position}"
    puts "Orientation: #{@orientation}"
    puts "============================="
  end

  private

  # Actions

  def place(arguments)
    tokens = arguments.split(/,/)
    x = tokens[0].to_i
    y = tokens[1].to_i
    orientation = tokens[2]

    @board.place(x, y)
    face(orientation)
  end

  def move
    return "Ignored, robot is not placed properly yet." if !@board.placed?

    new_x = @board.position[:x] + vector[:x]
    new_y = @board.position[:y] + vector[:y]
    if @board.place(new_x, new_y)
      nil
    else
      "Ignored MOVE action, it's out of boundary"
    end
  end

  def left
    @orientation = { "NORTH": "WEST", "WEST": "SOUTH", "SOUTH": "EAST", "EAST": "NORTH" }[@orientation]
  end

  def right
    @orientation = { "NORTH": "EAST", "EAST": "SOUTH", "SOUTH": "WEST", "WEST": "NORTH" }[@orientation]
  end

  def face(orientation)
    if ["NORTH", "SOUTH", "EAST", "WEST"].include?(orientation)
      @orientation = orientation
    else
      puts "Orientation is not valid."
    end
  end

  def vector
    case @orientation
    when "NORTH"
      { x: 0, y: 1 }
    when "SOUTH"
      { x: 0, y: -1 }
    when "EAST"
      { x: 1, y: 0 }
    when "WEST"
      { x: -1, y: 0 }
    else
      raise "Unknow orientation: #{@orientation}"
    end
  end
end




## Run this bot
robot = Robot.new

command = STDIN.gets
while command
  robot.execute(command)

  robot.report

  command = STDIN.gets
end
