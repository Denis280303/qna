# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string
#  file            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :integer
#
# Indexes
#
#  index_attachments_on_attachable_id_and_attachable_type  (attachable_id,attachable_type)
#
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to :attachable }
end
