class AddTodoListId < ActiveRecord::Migration
  def up
    add_column :todos, :todo_list_id, :integer
  end

  def down
    remove_column :todos, :todo_list_id
  end
end
