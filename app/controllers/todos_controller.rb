class TodosController < ApplicationController
  before_filter :load_todos

  def index
    @todos = Todo.grouped_by_list_names
  end

  def new
    @todo = Todo.new
  end

  def show
    @todo = Todo.find params[:id]
  end

  def create
    @todo = Todo.new params[:todo]
    @todo.update_attributes(params[:todo]) ?  redirect_to(@todo) : render(:edit)
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
