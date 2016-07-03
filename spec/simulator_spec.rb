require_relative "../toy_robot/simulator"

describe "Simulator" do
  let(:simulator) { Simulator.new }

  describe "#execute" do
    context "when invalid command" do
      before do
        expect(simulator).not_to receive(:dispatch_command)
      end
      ["PLACed", " PLACE", "HELLO", "123", "   ", ""].each do |command|
        it "ignores command #{command}" do
          simulator.execute(command)
        end
      end
    end

    context "when valid command" do
      context "when robot has not been placed yet" do
        describe "Other commands than PLACE" do
          before do
            expect_any_instance_of(Robot).to_not receive(:face!)
            expect_any_instance_of(Board).to_not receive(:place!)
          end

          ["MOVE", "LEFT", "RIGHT", "REPORT"].each do |command|
            it "ignores command #{command}" do
              simulator.execute(command)
            end
          end
        end

        describe "PLACE" do
          context "when invalid orientation argument" do
            it "ignores command and show messages to interface" do
              expect(simulator.execute("PLACE 1,2,INVALID")).to eq("Ignored - invalid orientation")
            end
          end

          context "when invalid cordinate arguments" do
            it "ignored and show message to interface" do
              expect(simulator.execute("PLACE one,two,NORTH")).to eq("Ignored - coordinate should be a number")
            end
          end

          context "when invalid arguments count" do
            it "ignored and show message to interface" do
              expect(simulator.execute("PLACE 1,1,NORTH,WAYNE")).to eq("Ignored - PLACE requires 3 arguments. ex: PLACE 1,2,NORTH")
            end
          end

          context "when valid arguments" do
            it "tells board to place robot on the board" do
              expect_any_instance_of(Board).to receive(:place!)

              simulator.execute("PLACE 1,2,NORTH")
            end

            it "tells robot to face to an orientation" do
              expect_any_instance_of(Robot).to receive(:face!)

              simulator.execute("PLACE 1,2,NORTH")
            end
          end
        end
      end

      context "when robot has been placed" do
        before do
          simulator.execute("PLACE 1,2,NORTH")
        end

        describe "PLACE" do
          it "tells board to places robot on the board" do
            expect_any_instance_of(Board).to receive(:place!).with(2,3)

            simulator.execute("PLACE 2,3,SOUTH")
          end

          it "tells robot to face to an orientation" do
            expect_any_instance_of(Robot).to receive(:face!).with(:south)

            simulator.execute("PLACE 2,3,SOUTH")
          end
        end

        describe "MOVE" do
          it "tells robot to move" do
            expect_any_instance_of(Board).to receive(:place!).with(1,3)

            simulator.execute("MOVE")
          end
        end

        describe "LEFT" do
          it "tells robot to turn left" do
            expect_any_instance_of(Robot).to receive(:turn_left!)

            simulator.execute("LEFT")
          end
        end

        describe "RIGHT" do
          it "tells robot to turn right" do
            expect_any_instance_of(Robot).to receive(:turn_right!)

            simulator.execute("RIGHT")
          end
        end

        describe "REPORT" do
          it "reports formated as (x,y,orientation)" do
            expect(simulator.execute("REPORT")).to eq("1,2,NORTH")
          end
        end
      end
    end
  end
end