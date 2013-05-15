require 'spec_helper'

describe TodoList do
  describe "#normalize_name" do
    it "should parameterize the name" do
      subject.name = "My groceries"
      subject.send :normalize_name
      subject.name.should == "my-groceries"
    end
  end
end
