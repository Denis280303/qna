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
require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many :attachments }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should accept_nested_attributes_for :attachments }
  it { should have_many(:subscribe_lists).dependent(:destroy) }
  it { should have_many(:subscribers) }

  describe 'Subscriprions' do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }
    let(:question) { create(:question, user: user) }

    describe '#subscribe_author' do
      subject { build(:question, user: user) }

      it 'adds user to subscribers after create' do
        expect(subject).to receive(:subscribe).with(subject.user)
        subject.save!
      end
    end

    describe '#subscribe' do
      it 'add given user to subscribers' do
        expect { question.subscribe(user1) }.to change(question.subscribers, :count).by 1
      end

      it 'doesnt add user to subscribers if he is already there' do
        expect { question.subscribe(question.user) }.to_not change(question.subscribers, :count)
      end
    end

    describe '#unsubscribe' do
      it 'delete given user from subscribers' do
        expect { question.unsubscribe(user) }.to change(question.subscribers, :count).by(-1)
      end

      it 'doesnt delete user from subscribers if he is not in' do
        expect { question.unsubscribe(user1) }.to_not change(question.subscribers, :count)
      end
    end
  end
end
