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
        if request.post?
            # entry = Transaction.
            # entry.name = params[:name]
            # entry.description = params[:description]
            # entry.amount = params[:amount]
            # entry.date = params[:date]
            # if entry.save
            #     CurrentBudget.subtract(entry.amount)
            #     redirect_to home_path
            # end
        end
    end

    def delete
    end

    def show
    end

end
