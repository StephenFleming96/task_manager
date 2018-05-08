class AddStatusToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :status, :number
  end
end
