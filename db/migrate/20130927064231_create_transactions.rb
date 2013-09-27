class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.date :date

      t.timestamps
    end
  end
end
