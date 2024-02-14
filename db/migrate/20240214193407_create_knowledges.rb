class CreateKnowledges < ActiveRecord::Migration[7.1]
  def change
    create_table :knowledges do |t|
      t.string :title

      t.timestamps
    end
  end
end
