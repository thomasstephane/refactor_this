require "spec_helper"

describe "Edit a new todo" do
  it "should update the todo" do
    list = TodoList.create :name => "a-test-list"
    todo = list.todos.create :title => "my todo", :status => 0
    visit edit_todo_path(todo)
    fill_in "Title", :with => "buy milk"
    fill_in "List name", :with => "My Groceries"
    click_link_or_button "Update Todo"
    page.should have_content 'buy milk'
    page.should have_content 'my-groceries'
  end
end
