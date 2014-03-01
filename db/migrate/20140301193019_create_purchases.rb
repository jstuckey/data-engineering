class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :count
      t.belongs_to :customer

      t.timestamps
    end
  end
end
