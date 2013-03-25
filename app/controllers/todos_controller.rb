class TodosController < ApplicationController
  before_filter :load_todos

  def index
    @todos = Todo.group_by_list_names
  end

  def new
    @todo = Todo.new
  end

  def show
    @todo = Todo.find params[:id]
  end

  def create
    @todo = Todo.new params[:todo]
    @todo.save ? redirect_to(root_url) : render(:new)
  end

  def edit
    @todo = Todo.find params[:id]
  end

  def update
    @todo = Todo.find params[:id]
    @todo.update_attributes(params[:todo]) ?  redirect_to(@todo) : render(:edit)
  end

  private

  def load_todos
    @todos = Todo.all
  end
end
