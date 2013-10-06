class IndexController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def home
		#if over budget -- red text
		if BudgetHistory.find_by_user_id(current_user.id) && CurrentBudget.find_by_user_id(current_user.id)
			@current_budget = CurrentBudget.find_by_user_id(current_user.id).budget.to_s
			@current_month_transactions = Transaction.all.group_by { |t| t.date.beginning_of_month }[Date.current.beginning_of_month]
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
