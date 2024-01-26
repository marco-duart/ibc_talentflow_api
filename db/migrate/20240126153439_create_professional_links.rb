class CreateProfessionalLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :professional_links do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
