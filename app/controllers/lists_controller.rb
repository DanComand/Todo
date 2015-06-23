class ListsController < ApplicationController
  def index
  	@lists = List.all
  end

  def new
  	@list = List.new
  end

  def show
  	@list = List.find(params[:id])
    if current_user
      @todo = @list.todos.build
    end
  end

  def create
  	@list = List.new(list_params)

  	if @list.save
  		redirect_to lists_url
  	else
  		render :new
  	end
  end

  def update
  	@list = List.find(params[:id])

  	if @list.update_attributes(product_params)
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
