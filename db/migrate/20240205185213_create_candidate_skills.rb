class CreateCandidateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_skills do |t|

      t.timestamps
    end
    add_reference :candidate_skills, :candidate, null: false, foreign_key: true
    add_reference :candidate_skills, :skill, null: false, foreign_key: true
  end
end
