class AddStartTimeToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :start, :datetime
  end
end
