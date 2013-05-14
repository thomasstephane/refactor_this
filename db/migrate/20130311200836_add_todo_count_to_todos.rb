class AddTodoCountToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :todo_count, :integer
  end
end
