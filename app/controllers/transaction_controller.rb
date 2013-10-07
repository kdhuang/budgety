class TransactionController < ApplicationController

    before_filter :login_required?, :except => [:login, :logout, :index]

    def new
        if request.post?
            new_entry = Transaction.new
            new_entry.name = params[:name]
            new_entry.description = params[:description]
            new_entry.amount = params[:amount]
            new_entry.date = Date.new(params[:date]['(1i)'].to_i, params[:date]['(2i)'].to_i, params[:date]['(3i)'].to_i)
            new_entry.user_id = current_user.id
            if new_entry.save
                CurrentBudget.subtract(current_user,new_entry.amount)
                redirect_to home_path
            end
    	end
    end

    def edit
        @transaction = Transaction.find(params[:transaction])
        if request.post?
            entry = @transaction
            entry.name = params[:name]
            entry.description = params[:description]
            entry.amount = params[:amount]
            entry.date = params[:date]
            if entry.save
                amount_difference = entry.amount - @transaction.amount
                CurrentBudget.subtract(amount_difference)
                redirect_to home_path
            end
        end
    end

    def delete
    end

    def show
    end

end
