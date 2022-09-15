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
class Attachment < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	
	mount_uploader :file, FileUploader
end
