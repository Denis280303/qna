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
class Answer < ApplicationRecord
  include Votable
  include Commentable

  default_scope { order(best: :desc, created_at: :asc) }

  belongs_to :user, touch: true
  belongs_to :question, touch: true
  has_many :attachments, as: :attachable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

  def mark_best_answer!
    transaction do
      self.class.where(question_id: question_id).update_all(best: false)
      update!(best: true)
    end
  end
end
