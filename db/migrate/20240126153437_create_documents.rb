class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :document_name
      t.string :document_number
      t.datetime :issue_date
      t.string :location
      t.string :image

      t.timestamps
    end
  end
end
