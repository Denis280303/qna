class Answer < ActiveRecord::Base
  belongs_to :question, touch: true 

  validates :body, presence: true
end
