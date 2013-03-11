class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :list_name
end
