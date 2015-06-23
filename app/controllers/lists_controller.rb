class ListsController < ApplicationController

before_filter :ensure_logged_in, only: [:index, :show, :create, :destroy]

  def index
  	@lists = current_user.lists.order(created_at: :desc)
  end

  def new
  	@list = List.new
  end

  def show
  	@list = List.find(params[:id])
    @todos = @list.todos.order(created_at: :desc)
  end

  def create
  	@list = List.new(list_params)
    @list.user_id = current_user.id
  	if @list.save
  		redirect_to :back 
  	else
  		render :new
  	end
  end

  def update
  	@list = List.find(params[:id])

  	if @list.update_attributes(list_params)
  		redirect_to list_path(@list)
  	else
  		render :edit
  	end
  end

  def destroy
  	@list = List.find(params[:id])
  	@list.destroy
  	redirect_to lists_path
  end

  private
  def list_params
  	params.require(:list).permit(:name, :user_id)
  end
end
