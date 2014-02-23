class BudgetHistoryController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def new
		if request.post?
			budget = BudgetHistory.new
			budget.budget = params[:budget]
			budget.current = true
			budget.user_id = current_user.id
			if budget.save
				new_current_budget = CurrentBudget.new
				new_current_budget.budget = budget.budget
				new_current_budget.user_id = current_user.id
				if new_current_budget.save
					redirect_to home_path
				end
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
				if prev_budget.save
					CurrentBudget.recalculate(current_user, budget.budget)
					redirect_to home_path
				end
			end
		end
	end

	
	# deprecated - allows manual recalculation of budget on home page. replaced by auto recalculation upon each page load
	#def reset
	#	CurrentBudget.recalculate(current_user, BudgetHistory.where("user_id = '#{current_user.id}'").last.budget)
	#	redirect_to home_path
	#end
end
