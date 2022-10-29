class RenameUsersAnswers < ActiveRecord::Migration[7.0]
  def up
    rename_column :users_answers, :detail, :answers
    rename_table :users_answers, :assessments
  end

  def down
    rename_table :assessments, :users_answers
    rename_column :users_answers, :answers, :detail
  end
end
