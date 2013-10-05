class AddUserId < ActiveRecord::Migration
  def change
  	add_column :transactions, :user_id, :integer
  	add_column :budget_histories, :user_id, :integer
  end
end
