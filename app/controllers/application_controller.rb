class ApplicationController < ActionController::Base
	protect_from_forgery

	def login_required?
		if session[:name]
			return false
		end
		flash[:failed_login] = "Please log in first!"
		redirect_to :controller => "index", :action => "index"
		return true
	end

	helper_method :current_user, :current_month

	def current_user
		@current_user ||= User.find_by_name(session[:name]) if session[:name]
	end
end
