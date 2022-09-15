# == Schema Information
#
# Table name: attachments
#
#  id          :bigint           not null, primary key
#  file        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#
# Indexes
#
#  index_attachments_on_question_id  (question_id)
#
FactoryBot.define do
  factory :attachment do
    file { "MyString" }
  end
end
