class TodosController < ApplicationController
	before_filter :load_list
	before_filter :ensure_logged_in, only: [:index, :show, :create, :destroy]

  def index
    @todos = current_user.todos.order(created_at: :desc)
  end

  # def show
  # 	@todo = Todo.find(params[:id])
  # end

  def create
  	@todo = @list.todos.build(todo_params)
  	@todo.user = current_user

  	if @todo.save
  		redirect_to lists_path(@lists), notice: 'Todo added'
  	else
  		render 'lists/show'
  	end
  end

  def destroy
  	@todo = Todo.find(params[:id])
  	@todo.destroy
  end

  private
  def todo_params
  	params.require(:todo).permit(:task, :list_id, :user_id)
  end

  def load_list
  	@list = List.find(params[:list_id])
  end
end
