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
        @transaction_months = Hash.new
        BudgetHistory.find_all_by_user_id(current_user).group_by{|t| t.updated_at.beginning_of_month}.each do |k,v|
            usage = 0 
            budget = v.last.budget
            next if !Transaction.find_all_by_user_id(current_user).group_by{|t| t.date.beginning_of_month}.keys.include? k.to_date
            Transaction.find_all_by_user_id(current_user).group_by{|t| t.date.beginning_of_month}[k.to_date].each do |t|
                usage += t.amount.to_f
            end
            @transaction_months[k.to_date] = [budget-usage, budget]
        end
    end

    def show_month
        @month = params[:month].to_date
        @monthly_transactions = Transaction.find_all_by_user_id(current_user).group_by {|t| t.date.beginning_of_month}[@month]
        return
        redirect_to show_month_transaction_path
    end

end
