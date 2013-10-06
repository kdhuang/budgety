class CurrentBudget < ActiveRecord::Base
	belongs_to :user

	def self.recalculate
	end

	def self.subtract(user, amount)
		current = CurrentBudget.find_by_user_id(user.id)
		current.budget = current.budget.to_f - amount
		current.save
	end
end
