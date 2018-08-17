class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	def after_sign_in_path_for(resource_or_scope)
		internal_control_path
	end
end