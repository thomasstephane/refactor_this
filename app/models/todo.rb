class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :list_name, :todo_count, :status

  before_validation :normalize_list_name
  after_save :update_todo_counts

  state_machine :state, :initial => :incomplete do
    event :in_progress do
      transition all => :in_progress
    end

    event :complete do
      transition all => :completed
    end
  end

  def moved?
    self.status == 3
  end

  def postponed?
    self.status == 5
  end

  def deleted?
    !!self.deleted_at
  end

  def moved!
    self.update_attributes :status => 3
  end

  def postponed!
    self.update_attributes :status => 5
  end

  def deleted!
    self.update_attributes :deleted_at => Time.now
  end

  def important!
    self.update_attributes :important => true
  end

  scope :all_moved, where(:status => 3)
  scope :all_deleted, where("deleted_at NOT NULL")
  scope :all_postponed, where(:status => 5)
  scope :all_important, where(:important => true)

  private

  def normalize_list_name
    self.list_name = self.list_name.parameterize
  end

  # updates own todo_count and siblings
  # doesn't update todo_count in memory, need to refactor todo_count to be on a TodoList
  def update_todo_counts
    count = Todo.where(:list_name => self.list_name).count
    Todo.where(:list_name => self.list_name).update_all(:todo_count => count)
  end

end
