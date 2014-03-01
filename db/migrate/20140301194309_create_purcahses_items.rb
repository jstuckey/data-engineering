class CreatePurcahsesItems < ActiveRecord::Migration
  def change
    create_table :purcahses_items do |t|
    	t.belongs_to :purchase
      	t.belongs_to :item

      	t.timestamps
    end
  end
end
