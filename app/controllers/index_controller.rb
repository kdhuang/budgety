class IndexController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def home
		#if over budget -- red text
		if BudgetHistory.find_by_user_id(current_user)
			@current_budget = BudgetHistory.where(:current => true).find_by_user_id(current_user.id).budget.to_s
		else
			redirect_to new_budget_path
		end
	end

	def index
		if current_user
			redirect_to home_path
		end
	end
end
