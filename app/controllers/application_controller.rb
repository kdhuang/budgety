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
end
