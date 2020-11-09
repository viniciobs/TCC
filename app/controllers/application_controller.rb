class ApplicationController < ActionController::Base		
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!
	before_action :check_user_active

	protected

	def configure_permitted_parameters
		added_attrs = [:username, :name, :password, :password_confirmation, :remember_me]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end

	def after_sign_in_path_for(resource)
		return get_route(resource)
	end

	def render_404
		respond_to do |format|
			format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
			format.xml  { head :not_found }
			format.any  { head :not_found }
		end
	end

	private 

	def get_route resource 
		
		if !resource.active			
			return users_inactive_users_path(id: resource.id)
	 	elsif resource.user_type == 'manager'
	    	return stocks_path
	 	elsif resource.user_type == 'musician'
	    	return songs_path
		else
			return rates_path
		end
	end

	def check_user_active				
		redirect_to get_route(current_user) if !current_user.nil? && ((!current_user.active? && request.path != users_inactive_users_path(id: current_user.id) && request.path != destroy_user_session_path) || current_user.active? && request.path == users_inactive_users_path(id: current_user.id))		
	end


end
