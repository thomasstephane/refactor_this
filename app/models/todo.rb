class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :todo_count, :status
  belongs_to :todo_list, :counter_cache => :todo_count

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
end
