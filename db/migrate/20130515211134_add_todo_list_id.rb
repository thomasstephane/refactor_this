class AddTodoListId < ActiveRecord::Migration
  def up
    add_column :todos, :todo_list_id, :integer

    grouped_by_list_name = Todo.all.group_by { |todo| todo.list_name }
    grouped_by_list_name.each do |list_name, todos|
      Todo.transaction do
        todo_list = TodoList.find_or_create_by_list_name(list_name)
        todos.each do |todo|
          todo.update_column :todo_list_id, todo_list.id
        end
      end
    end
  end

  def down
    remove_column :todos, :todo_list_id
  end
end
