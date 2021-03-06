class CurrentBudget < ActiveRecord::Base
	belongs_to :user

	def self.recalculate(user, new_budget)
		current_month_transactions = Transaction.find_all_by_user_id(user).group_by { |t| t.date.beginning_of_month }[Date.current.beginning_of_month]
		current = CurrentBudget.find_by_user_id(user.id)
		current.budget = new_budget
		if current_month_transactions != nil
			current_month_transactions.each do |d|
				current.budget = current.budget - d.amount.to_f
			end
		end
		current.save
	end

	def self.subtract(user, amount)
		current = CurrentBudget.find_by_user_id(user.id)
		current.budget = current.budget.to_f - amount
		current.save
	end
end
