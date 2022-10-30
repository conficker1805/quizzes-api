class AddStartedAtAndEndAtToAssessments < ActiveRecord::Migration[7.0]
  def up
    add_column :assessments, :started_at, :datetime
    add_column :assessments, :ended_at, :datetime

    rename_column :answers, :active, :state
  end

  def down
    remove_column :assessments, :started_at
    remove_column :assessments, :ended_at

    rename_column :answers, :state, :active
  end
end
