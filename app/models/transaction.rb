class Transaction < ActiveRecord::Base
	belongs_to :user

	validates :name, :presence => {:message => "A name is required."}
	validates :amount, :presence => {:message => "An amount is required."}
end
