class BudgetHistoryController < ApplicationController

	before_filter :login_required?, :except => [:login, :logout, :index]

	def new

	end

	def edit

	end

	def show

	end
	
end
