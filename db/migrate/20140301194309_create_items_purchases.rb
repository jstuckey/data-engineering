class CreateItemsPurchases < ActiveRecord::Migration
  def change
    create_table :items_purchases do |t|
    	t.belongs_to :item
    	t.belongs_to :purchase

      	t.timestamps
    end
  end
end
