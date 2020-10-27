class AddUserIdToTasks < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    delete_reference :tasks, :user, index: true
  end
end
