class User < ActiveRecord::Base
	has_many :budget_histories
	has_many :transactions
	has_one :current_budgets

	def self.authenticate(name,password)
		user = find_by_name(name)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			return true
		end
		return nil    
	end
  
	def encrypt_password(password)
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end

	def self.create_new_account(name,password)
		new_user = User.new
		new_user.name = name
		new_user.encrypt_password(password)
		new_user.save
	end
end
