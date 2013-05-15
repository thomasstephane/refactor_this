class AddTodoDeletedAt < ActiveRecord::Migration
  def up
    add_column :todos, :deleted_at, :datetime
    Todo.where(:status => 4).update_all(:deleted_at => Time.now)
  end

  def down
    remove_column :todos, :deleted_at
  end
end
