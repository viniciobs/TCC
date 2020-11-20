class MenuController < ApplicationController
	before_action :check_user_permission, except: [:inactive]
	
	def index		
		@categories = ProductCategory.all.order(:name)
		@stock = Stock.where('quantity > 0')
		@order = current_user.order
	end
  	
	private 
	
	def check_user_permission
  		render_access_denied if !current_user.nil? && current_user.user_type != 'customer'
  	end
end
