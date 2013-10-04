class TransactionController < ApplicationController

    before_filter :login_required?, :except => [:login, :logout, :index]

    def new
    	new_entry = Transaction.new
    	new_entry.name = params[:name]
    	new_entry.description = params[:description]
    	new_entry.amount = params[:amount]
    	new_entry.date = params[:date]
    	new_entry.save
    	#call to subtract from budget
    end

    def edit
    end

    def show
    end

end
