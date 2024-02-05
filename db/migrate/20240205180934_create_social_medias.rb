class CreateSocialMedias < ActiveRecord::Migration[6.1]
  def change
    create_table :social_medias do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
