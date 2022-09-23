# frozen_string_literal: true

# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  value        :integer          not null
#  votable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  votable_id   :bigint
#
# Indexes
#
#  index_votes_on_user_id                                  (user_id)
#  index_votes_on_user_id_and_votable_id_and_votable_type  (user_id,votable_id,votable_type) UNIQUE
#  index_votes_on_votable                                  (votable_type,votable_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
describe Vote, type: :model do
  it { should belong_to :user }
  it { should belong_to :votable }

  it { should validate_presence_of :value }

  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }

  it { should have_db_column(:value).of_type(:integer) }

  describe 'the uniqueness of the user scoped to votable' do
    before do
      user = create(:user)
      votable_question = create(:question, id: 1, user: user)
      votable_answer = create(:answer, id: 1, user: user)

      create(:vote, user: user, votable: votable_question, value: 1)
      create(:vote, user: user, votable: votable_answer, value: 1)
    end

    it { is_expected.to validate_uniqueness_of(:user).scoped_to(%i[votable_id votable_type]) }
  end
end
