class BudgetHistoryController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def new
		if request.post?
			budget = BudgetHistory.new
			budget.budget = params[:budget]
			budget.current = true
			if budget.save
				redirect_to home_path
			end
		end
	end

	def edit

	end

	def show

	end
	
end
