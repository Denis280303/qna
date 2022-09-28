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
FactoryBot.define do
  factory :vote do
    value { 1 }
    user { nil }
  end
end
