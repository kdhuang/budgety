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
            p "++++++++++++++++++++++"
            p new_entry.errors
            p request.fullpath
            p request.path
            if new_entry.save
                CurrentBudget.subtract(current_user,new_entry.amount)
                redirect_to home_path
            end
    	end
    end

    def edit
        transaction = Transaction.find(params[:transaction])
        @id = transaction.id
        @name = transaction.name
        @description = transaction.description
        @amount = transaction.amount
        @date = transaction.date
        if request.post? && params[:old_amount]
            entry = Transaction.find(params[:transaction])
            entry.name = params[:name]
            entry.description = params[:description]
            entry.amount = params[:amount]
            entry.date = Date.new(params[:newdate][params[:old_date] + '(1i)'].to_i, params[:newdate][params[:old_date] + '(2i)'].to_i, params[:newdate][params[:old_date] + '(3i)'].to_i)
            if entry.save
                amount_difference = entry.amount.to_f - params[:old_amount].to_f
                CurrentBudget.subtract(current_user, amount_difference)
                redirect_to home_path
            end
        end
    end

    def delete
        if request.post?
            entry = Transaction.find(params[:transaction])
            amount = entry.amount.to_f * -1
            if entry.destroy
                CurrentBudget.subtract(current_user, amount)
            end
            redirect_to home_path
        end
    end

    def show
    end

end
