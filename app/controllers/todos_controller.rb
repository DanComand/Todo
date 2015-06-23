class TodosController < ApplicationController
	before_filter :load_list

  def index

  end

  def show
  	@todo = Todo.find(params[:id])
  end

  def create
  	@todo = @list.todos.build(todo_params)
  	@todo.user = current_user

  	if @todo.save
  		redirect_to lists_path, notice: 'Todo added'
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
  	params.require(:todo).permit(:task)
  end

  def load_list
  	@list = List.find(params[:list_id])
  end
end
