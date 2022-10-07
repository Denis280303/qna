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
require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { build(:answer) }
  
  it { should belong_to(:question).touch(true) }
  it { should validate_presence_of :body }
  it { should have_many :attachments }

  it { should accept_nested_attributes_for :attachments }

  describe '#report_to_subscribers', :focus do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    subject { build(:answer, user: user, question: question) }

    it 'send email to question subscribers' do
      subject.question.subscribers.each { |user| expect(ReportMailer).to receive(:report).with(user, subject).and_call_original }
      subject.save!
    end
  end
end
