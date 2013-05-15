require "spec_helper"

describe Todo do
  describe "#normalize_list_name" do
    it "should parameterize the list name" do
      subject.list_name = "My groceries"
      subject.send :normalize_list_name
      subject.list_name.should == "my-groceries"
    end
  end

  describe "#update_todo_count" do
    let(:list_name) { "my groceries" }
    it "should update the todo count of all items in the list" do
      todo = Todo.create :list_name => list_name, :title => "some title"
      subject.list_name = list_name
      subject.save
      subject.reload.todo_count.should == 2
      todo.reload.todo_count.should == 2
    end
  end
end
