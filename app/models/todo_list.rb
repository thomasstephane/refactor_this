class TodoList < ActiveRecord::Base
  attr_accessible :name

  has_many :todo

  before_validation :normalize_name

  private

  def normalize_name
    self.name = self.name.parameterize
  end

end
