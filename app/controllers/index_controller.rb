class IndexController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def home
		#calculate the total to display -- display in home.html.haml view
	end
end
