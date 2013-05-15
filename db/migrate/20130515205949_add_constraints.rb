class AddConstraints < ActiveRecord::Migration
  def up
    change_column_null :todos, :title, false
    change_column_null :todos, :status, false
    change_column_null :todos, :state, false
    change_column_null :todos, :state, false
    change_column_default :todos, :state, false
  end

  def down
    change_column_null :todos, :title, nil
    change_column_null :todos, :status, nil
    change_column_null :todos, :state, nil
    change_column_null :todos, :state, nil
    change_column_default :todos, :state, nil
  end
end
