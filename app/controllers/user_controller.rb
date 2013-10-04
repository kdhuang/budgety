class UserController < ApplicationController

  before_filter :login_required?, :except => [:login, :logout, :index]

	def login
		if params[:name]
			@user = User.find_by_name(params[:name])
			error_notice = "Incorrect name or password. Please try again."
  			if @user.nil?
  				flash[:failed_login] = incorrect_credentials_notice
  				redirect_to root_path
  			else
  				name = params[:name]
  				password = params[:password]
        	
        		unless name.nil?
        			if User.authenticate(name,password)
        				session[:name] = name
        				redirect_to '/home'
        			else
        				flash[:failed_login] = incorrect_credentials_notice
        				redirect_to root_path
        			end
        		end
        	end
        end
    end

    def logout
    	session[:name] = nil
    	redirect_to root_path
    end

    def index
      if session[:user]
        redirect_to :root_path
      end
    	redirect_to :root_path
    end
end
