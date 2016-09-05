class Admin::ProductsController < ApplicationController
	def index
		@products = Product.all
	end
	def create
	end
	def new
	  @product = Product.new
	end
	def edit
	end
	def show
		@product = Product.find(params[:id])
	end
	def update
	end
	def destroy
	end
end
