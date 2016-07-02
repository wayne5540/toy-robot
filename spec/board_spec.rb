require_relative "../toy_robot/board"

describe "Board" do
  let(:board) { Board.new }

  describe "#place!" do
    context "when cordinate is whithin boundary" do
      it "sets position correctly" do
        expect(
          board.place!(0,4)
        ).to eq(
          {x: 0, y: 4}
        )
      end
    end

    context "when cordinate is out of boundary" do
      it "ignores placement if x < 0" do
        expect(board.place!(-1,2)).to be nil
      end

      it "ignores placement if x > 4" do
        expect(board.place!(5,2)).to be nil
      end

      it "ignores placement if y < 0" do
        expect(board.place!(1,-1)).to be nil
      end

      it "ignores placement if y > 4" do
        expect(board.place!(1,5)).to be nil
      end
    end
  end

  describe "placed?" do
    context "when already placed" do
      before { board.place!(0,4) }

      it "returns true" do
        expect(board.placed?).to be true
      end
    end

    context "when placement not made correctly yet" do
      it "returns false if no placement been made" do
        expect(board.placed?).to be false
      end

      it "returns false if an invalid placement was made" do
        board.place!(-1,4)
        expect(board.placed?).to be false
      end
    end
  end


  describe "report_position" do
    before { board.place!(0,4) }

    it "returns cordinate as x,y" do
      expect(board.report_position).to eq("0,4")
    end
  end
end