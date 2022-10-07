# == Schema Information
#
# Table name: subscribe_lists
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_subscribe_lists_on_question_id  (question_id)
#  index_subscribe_lists_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :subscribe_list do
    
  end
end
