class CreateTodo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.string :body
      t.string :list_name
    end
  end
end
