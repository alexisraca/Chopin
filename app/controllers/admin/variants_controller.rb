class Admin::VariantsController < ApplicationController
	def index
		@variants = Variant.all
	end
end
