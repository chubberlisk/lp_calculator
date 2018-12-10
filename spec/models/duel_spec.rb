require 'rails_helper'

RSpec.describe Duel, type: :model do
  let(:user_one) { build(:user_one) }
  let(:user_two) { build(:user_two) }

  describe '#status' do
    context 'when a completed duel' do
      let(:completed_duel) { build(:completed_duel, player_one: user_one, player_two: user_two) }

      it 'returns completed' do
        expect(completed_duel.status).to eq('completed')
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel, player_one: user_one, player_two: user_two) }

      it 'returns started' do
        expect(started_duel.status).to eq('started')
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel, player_one: user_one, player_two: user_two) }

      it 'returns cancelled' do
        expect(cancelled_duel.status).to eq('cancelled')
      end
    end
  end

  describe '#winner' do
    context 'when a completed duel' do
      context 'with player one the winner' do
        let(:p1_winner_duel) { build(:p1_winner_duel, player_one: user_one, player_two: user_two) }

        it 'returns the user with the highest life points' do
          expect(p1_winner_duel.winner).to eql(user_one)
        end
      end

      context 'with player two the winner' do
        let(:p2_winner_duel) { build(:p2_winner_duel, player_one: user_one, player_two: user_two) }

        it 'returns the user with the highest life points' do
          expect(p2_winner_duel.winner).to eql(user_two)
        end
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel) }

      it 'returns an error' do
        started_duel.winner
        expect(started_duel.errors[:winner].size).to eq(1)
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel) }

      it 'returns an error' do
        cancelled_duel.winner
        expect(cancelled_duel.errors[:winner].size).to eq(1)
      end
    end
  end

  describe '#winner?' do
    context 'when a completed duel' do
      context 'with player one the winner' do
        let(:p1_winner_duel) { build(:p1_winner_duel, player_one: user_one, player_two: user_two) }

        it 'returns true for user one' do
          expect(p1_winner_duel.winner?(user_one)).to be true
        end

        it 'returns false for user two' do
          expect(p1_winner_duel.winner?(user_two)).to be false
        end
      end

      context 'with player two the winner' do
        let(:p2_winner_duel) { build(:p2_winner_duel, player_one: user_one, player_two: user_two) }

        it 'returns true for user two' do
          expect(p2_winner_duel.winner?(user_two)).to be true
        end

        it 'returns false for user one' do
          expect(p2_winner_duel.winner?(user_one)).to be false
        end
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel) }

      it 'returns an error' do
        started_duel.winner?(user_one)
        expect(started_duel.errors[:winner?].size).to eq(1)
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel) }

      it 'returns an error' do
        cancelled_duel.winner?(user_one)
        expect(cancelled_duel.errors[:winner?].size).to eq(1)
      end
    end
  end

  describe '#my_lp' do
    context 'when a completed duel' do
      let(:completed_duel) { build(:completed_duel, player_one: user_one, player_two: user_two) }

      context 'with user equal to player one' do
        it 'returns the life points of user' do
          expect(completed_duel.my_lp(user_one)).to be(8000)
        end
      end

      context 'with user equal to player two' do
        it 'returns the life points of user' do
          expect(completed_duel.my_lp(user_two)).to be(0)
        end
      end

      context 'with user not a player of duel' do
        let(:user_three) { build(:user_three) }

        it 'returns an error' do
          completed_duel.my_lp(user_three)
          expect(completed_duel.errors[:my_lp].size).to eq(1)
        end
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel) }

      it 'returns an error' do
        started_duel.my_lp(user_one)
        expect(started_duel.errors[:my_lp].size).to eq(1)
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel) }

      it 'returns an error' do
        cancelled_duel.my_lp(user_one)
        expect(cancelled_duel.errors[:my_lp].size).to eq(1)
      end
    end
  end

  describe '#opponent' do
    let(:duel) { build(:duel, player_one: user_one, player_two: user_two) }

    context 'when user is player one' do
      it 'returns player two' do
        expect(duel.opponent(user_one)).to eql(user_two)
      end
    end

    context 'when user is player two' do
      it 'returns player one' do
        expect(duel.opponent(user_two)).to eql(user_one)
      end
    end

    context 'when user is not a player in the duel' do
      let(:user_three) { build(:user_three) }

      it 'returns an error' do
        duel.opponent(user_three)
        expect(duel.errors[:opponent].size).to eq(1)
      end
    end
  end

  describe '#opponents_lp' do
    context 'when a completed duel' do
      let(:completed_duel) { build(:completed_duel, player_one: user_one, player_two: user_two) }

      context 'with user equal to player one' do
        it 'returns the life points of opponent' do
          expect(completed_duel.opponents_lp(user_one)).to be(0)
        end
      end

      context 'with user equal to player two' do
        it 'returns the life points of opponent' do
          expect(completed_duel.opponents_lp(user_two)).to be(8000)
        end
      end

      context 'with user not a player of duel' do
        let(:user_three) { build(:user_three) }

        it 'returns an error' do
          completed_duel.opponents_lp(user_three)
          expect(completed_duel.errors[:opponents_lp].size).to eq(1)
        end
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel) }

      it 'returns an error' do
        started_duel.opponents_lp(user_one)
        expect(started_duel.errors[:opponents_lp].size).to eq(1)
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel) }

      it 'returns an error' do
        cancelled_duel.opponents_lp(user_one)
        expect(cancelled_duel.errors[:opponents_lp].size).to eq(1)
      end
    end
  end

  describe '#time' do
    context 'when a completed duel' do
      let(:fifteen_mins_duel) { build(:fifteen_mins_duel, player_one: user_one, player_two: user_two) }
      let(:thirty_mins_duel) { build(:thirty_mins_duel, player_one: user_one, player_two: user_two) }
      let(:sixty_mins_duel) { build(:sixty_mins_duel, player_one: user_one, player_two: user_two) }

      it 'returns the duel time for a 15 mins duel' do
        expect(fifteen_mins_duel.time).to eq("15 mins")
      end

      it 'returns the duel time for a 30 mins duel' do
        expect(thirty_mins_duel.time).to eq("30 mins")
      end

      it 'returns the duel time for a 60 mins duel' do
        expect(sixty_mins_duel.time).to eq("60 mins")
      end
    end

    context 'when a started duel' do
      let(:started_duel) { build(:started_duel) }

      it 'returns an error' do
        started_duel.time
        expect(started_duel.errors[:time].size).to eq(1)
      end
    end

    context 'when a cancelled duel' do
      let(:cancelled_duel) { build(:cancelled_duel) }

      it 'returns an error' do
        cancelled_duel.time
        expect(cancelled_duel.errors[:time].size).to eq(1)
      end
    end
  end
end