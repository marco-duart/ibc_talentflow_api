class Document < ApplicationRecord
  # document_name: string
  # document_number: string
  # issue_date: datetime
  # location: string
  belongs_to :candidate
end
