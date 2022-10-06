# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  best        :boolean          default(FALSE), not null
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  sequence(:body) { |n| "AnswerBody-#{n}" }
  factory :answer do
    body { generate(:body) }

    association :question
    association :user

    trait :without_question do
      question { nil }
    end

    trait :invalid do
      body { nil }
    end

    trait :with_comments do
      after(:create) do |answer|
        create_list(:comment, 3, commentable: answer)
      end
    end
  end
end
