class MenuController < ApplicationController
	before_action :check_user_permission, except: [:inactive]
	
	def index		
    @categories = ProductCategory.all
  end
  	
	private 
	
	def check_user_permission
  	render_404 if !current_user.nil? && current_user.user_type == 'manager'
  end
end
