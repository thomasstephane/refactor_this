class AddTodoImportant < ActiveRecord::Migration
  def up
    add_column :todos, :important, :boolean
    Todo.where(:status => 6).update_all(:important => true)
  end

  def down
    remove_column :todos, :important
  end
end
