class ApplicationController < ActionController::Base		
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!

	protected

	def configure_permitted_parameters
		added_attrs = [:username, :name, :password, :password_confirmation, :remember_me]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end

	def after_sign_in_path_for(resource)
	 	if resource.user_type == 'manager'
	    	return stocks_path
	 	elsif resource.user_type == 'musician'
	    	return songs_path
		else

		end
	end
end
