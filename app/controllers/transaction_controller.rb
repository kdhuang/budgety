class TransactionController < ApplicationController
    def index
        redirect_to root_url
    end

    def new(name, description, amount, date)
    	new_entry = Transaction.new
    	new_entry.name = name
    	new_entry.description = description
    	new_entry.amount = amount
    	new_entry.date = date
    	new_entry.save
    	#call to subtract from budget
    end

    def edit
    end

    def create
    end

    def show
    end

end
