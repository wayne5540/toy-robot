require_relative "../toy_robot/robot"

describe "Robot" do
  let(:robot) { Robot.new }

  describe "#face!" do
    context "when orientation is valid" do
      [:north, :south, :east, :west].each do |orientation|
        it "sets orientation as #{orientation}" do
          robot.face!(orientation)

          expect(robot.orientation).to eq(orientation)
        end
      end
    end

    context "when orientation is not valid" do
      it "returns false" do
        expect(robot.face!(:invalid)).to be false
      end
    end
  end


  describe "#turn_left!" do
    it "sets orientation from north to west" do
      robot.face!(:north)

      expect {
        robot.turn_left!
      }.to change {
        robot.orientation
      }.from(:north).to(:west)
    end

    it "sets orientation from west to south" do
      robot.face!(:west)

      expect {
        robot.turn_left!
      }.to change {
        robot.orientation
      }.from(:west).to(:south)
    end

    it "sets orientation from south to east" do
      robot.face!(:south)

      expect {
        robot.turn_left!
      }.to change {
        robot.orientation
      }.from(:south).to(:east)
    end

    it "sets orientation from east to north" do
      robot.face!(:east)

      expect {
        robot.turn_left!
      }.to change {
        robot.orientation
      }.from(:east).to(:north)
    end
  end

  describe "#turn_right!" do
    it "sets orientation from north to east" do
      robot.face!(:north)

      expect {
        robot.turn_right!
      }.to change {
        robot.orientation
      }.from(:north).to(:east)
    end

    it "sets orientation from east to south" do
      robot.face!(:east)

      expect {
        robot.turn_right!
      }.to change {
        robot.orientation
      }.from(:east).to(:south)
    end

    it "sets orientation from south to west" do
      robot.face!(:south)

      expect {
        robot.turn_right!
      }.to change {
        robot.orientation
      }.from(:south).to(:west)
    end

    it "sets orientation from west to north" do
      robot.face!(:west)

      expect {
        robot.turn_right!
      }.to change {
        robot.orientation
      }.from(:west).to(:north)
    end
  end

  describe "#report_orientation" do
    before { robot.face!(:north) }

    it "returns orientation in string uppercase" do
      expect(robot.report_orientation).to eq("NORTH")
    end
  end
end