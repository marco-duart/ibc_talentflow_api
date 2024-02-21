class AddHiringProcessStageIdToInterview < ActiveRecord::Migration[6.1]
  def change
    add_reference :interviews, :hiring_process_stage, null: false, foreign_key: true
  end
end
