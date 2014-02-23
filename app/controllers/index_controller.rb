class IndexController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def home
		if BudgetHistory.find_by_user_id(current_user.id) && CurrentBudget.find_by_user_id(current_user.id)
			CurrentBudget.recalculate(current_user, BudgetHistory.where("user_id = '#{current_user.id}'").last.budget)
			budget = CurrentBudget.find_by_user_id(current_user.id).budget
			if budget < 0
				@over_budget = true
			end
			@current_budget = budget.abs.to_s
			all_transactions = Transaction.find_all_by_user_id(current_user.id).group_by {|t| t.date.beginning_of_month}
			if Transaction.find_by_user_id(current_user.id)
				@current_month_transactions = all_transactions[Date.current.beginning_of_month]
			else
				@current_month_transactions = false
			end
			if !@current_month_transactions
				budget = BudgetHistory.new
				budget.budget = BudgetHistory.where(:current => true).find_by_user_id(current_user).budget
				budget.current = true
				budget.user_id = current_user.id
				budget.save
      		end
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
