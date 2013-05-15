class AddStateToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :state, :string
    Todo.where(:status => 0).update_all :state => "incomplete"
    Todo.where(:status => 1).update_all :state => "complete"
    Todo.where(:status => 2).update_all :state => "in_progress"
  end
end
