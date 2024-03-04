class CreateSocialLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :social_links do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
