
require "pry"


class Robot
  VALID_ACTIONS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]

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
    puts "Position: #{@position}"
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

    place_robot(x, y)
    face(orientation)
  end

  def move
  end

  def left
  end

  def right
  end

  def face(orientation)
    if ["NORTH", "SOUTH", "EAST", "WEST"].include?(orientation)
      @orientation = orientation
    else
      puts "Orientation is not valid."
    end
  end


  # Table

  def place_robot(x, y)
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




## Run this bot
robot = Robot.new

command = STDIN.gets
while command
  robot.execute(command)

  robot.report

  command = STDIN.gets
end
