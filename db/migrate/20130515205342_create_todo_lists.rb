class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name, :default => "", :null => false
      t.integer :todo_count, :default => 0, :null => false
      t.timestamps
    end
  end
end
