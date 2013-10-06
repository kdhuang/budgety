class BudgetHistoryController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def new
		if request.post?
			budget = BudgetHistory.new
			budget.budget = params[:budget]
			budget.current = true
			budget.user_id = current_user.id
			if budget.save
				redirect_to home_path
			end
		end
	end

	def update
		prev_budget = BudgetHistory.where("user_id = '#{current_user.id}'").last
		if request.post?
			budget = BudgetHistory.new
			budget.budget = params[:budget]
			budget.current = true
			budget.user_id = current_user.id
			if budget.save
				prev_budget.current = false
				prev_budget.save
				# call recalculate here
				redirect_to home_path
			end
		end
	end
end
