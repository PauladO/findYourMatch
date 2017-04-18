class RemoveStudentFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :student, :boolean
  end
end
