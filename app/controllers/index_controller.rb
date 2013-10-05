class IndexController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def home
		#calculate the total to display -- display in home.html.haml view
		@current_budget = BudgetHistory.find_by_user_id(current_user.id).budget.to_s
		p "+++++++++++++++++++++"
		p @current_budget
	end
end
