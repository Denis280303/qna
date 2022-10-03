# == Schema Information
# Schema version: 20220923084142
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { should belong_to :commentable }

  it { should validate_presence_of :body }
end
