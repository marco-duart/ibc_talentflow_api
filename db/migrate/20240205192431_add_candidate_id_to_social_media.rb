class AddCandidateIdToSocialMedia < ActiveRecord::Migration[6.1]
  def change
    add_reference :social_medias, :candidate, null: false, foreign_key: true
  end
end
