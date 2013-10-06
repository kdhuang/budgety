class CreateCurrentBudgets < ActiveRecord::Migration
  def change
    create_table :current_budgets do |t|
      t.decimal :budget
      t.integer :user_id
      
      t.timestamps
    end
  end
end
