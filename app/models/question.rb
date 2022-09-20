# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Question < ApplicationRecord
  belongs_to :user, touch: true
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, inverse_of: :attachable

  validates :title, presence: true
  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
