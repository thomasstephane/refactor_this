class Todo < ActiveRecord::Base

  attr_accessible :title, :body, :list_name, :todo_count, :status
  before_save :downcase_list_name, :update_count

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

  class << self

    def grouped_by_list_names
      self.all.group_by(&:list_name)
    end

    def method_missing(method, *args)
      if (method.to_s =~ /all_(.+)$/) && status == STATUS[$1.to_sym]
        self.where :status => status
      elsif method.to_s =~ /find_or_create_by_(.+)$/ && status == STATUS[$1.to_sym]
        self.create :status => status
      else
        super
      end
    end

  end

  private 

  def downcase_list_name
    self.list_name = self.list_name.downcase.gsub ' ', '-'
  end

  def update_count
    self.todo_count = Todo.where("list_name = ?", self.list_name).count
  end

end
