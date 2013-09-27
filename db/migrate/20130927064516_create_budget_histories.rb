class CreateBudgetHistories < ActiveRecord::Migration
  def change
    create_table :budget_histories do |t|
      t.decimal :budget
      t.boolean :current

      t.timestamps
    end
  end
end
