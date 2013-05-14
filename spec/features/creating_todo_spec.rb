require "spec_helper"

describe "Creating a new todo" do
  it "should parameterize the title" do
    visit new_todo_path
    fill_in "Title", :with => "buy milk"
    fill_in "List name", :with => "My Groceries"
    click_link_or_button "Create Todo"
    page.should have_content 'my-groceries'
  end
end
