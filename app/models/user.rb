class User < ActiveRecord::Base
	has_many :budget_histories
	has_many :transactions
end
