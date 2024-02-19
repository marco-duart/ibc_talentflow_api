class Document < ApplicationRecord
  # document_name: string
  # document_number: string
  # issue_date: datetime
  # location: string
  has_one_attached :image
  belongs_to :candidate
end
