class Todo < ActiveRecord::Base
  attr_accessible :title, :body, :list_name, :todo_count, :status

  before_save :normalize_list_name, :update_todo_count

  STATUS = {
    :incomplete   => 0,
    :complete     => 1,
    :in_progress  => 2,
    :moved        => 3,
    :deleted      => 4,
    :postponed    => 5,
    :important    => 6
  }.freeze

  STATUS.keys.each do |status|
    define_method "#{status}?" do
      self.status == STATUS[status]
    end
    define_method "#{status}!" do
      update_attributes :status => STATUS[status]
    end
  end

  def to_s
    "#{self.title}: #{self.body}"
  end

  class << self
    def group_by_list_names
      self.all.group_by &:list_name
    end

    def method_missing method, *args
      if method.to_s =~ /^all_(.+)$/ and status = STATUS[$1.to_sym]
        self.where :status => status
      elsif method.to_s =~ /^create_by_(.+)$/ and status = STATUS[$1.to_sym]
        self.create :status => status
      else
        super
      end
    end
  end

  private

  def normalize_list_name
    self.list_name = self.list_name.downcase.gsub ' ', '-'
  end

  def update_todo_count
    self.todo_count = Todo.count(:conditions => "list_name = '#{self.list_name}'")
  end

end
