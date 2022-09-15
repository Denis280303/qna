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
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to :question }
end
