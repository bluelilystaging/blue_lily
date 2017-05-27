class ItemsController < ApplicationController
	def index
		@items = Item.by_date
	end

	def new
		@item = Item.new
		@categories = Category.by_date
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			flash[:notice] = "Created item"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "new"
		end
	end

	def edit
		@item = Item.find(params[:id])
		@categories = Category.by_date
	end

	def update
		@item = Item.find(params[:id])
		if @item.update_attributes(item_params)
			flash[:notice] = "Updated item"
			redirect_to items_path
		else
			flash.now[:alert] = @item.errors.full_messages.first
			render "edit"
		end
	end

	def destroy
		@item = Item.find(params[:id])
		if @item.destroy
			flash[:notice] = "Deleted item"
		else
			flash[:alert] = @item.errors.full_messages.first
		end
		redirect_to items_path
	end

	private

		def item_params
			params.require(:item).permit(:name, :size, :condition, :purchase_price, :sale_price, :description, :company, :color, :category_id)
		end
end
