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
  include Votable
  include Commentable

  belongs_to :user, touch: true
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, inverse_of: :attachable
  has_many :subscribe_lists, dependent: :destroy
  has_many :subscribers, class_name: 'User', through: :subscribe_lists

  scope :created_yesterday, -> { where(created_at: Time.zone.now.yesterday.all_day) }

  after_create :subscribe_author

  validates :title, presence: true
  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

  def subscribe(user)
    self.subscribers << user unless has_subscribed? user
  end

  def unsubscribe(user)
    self.subscribers.delete(user) if has_subscribed? user
  end

  def has_subscribed?(user)
    subscribers.include? user
  end

  private

  def subscribe_author
    subscribe(user)
  end
end
