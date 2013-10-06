class CurrentBudget < ActiveRecord::Base
	belongs_to :user

	def self.calculate
	end
end
