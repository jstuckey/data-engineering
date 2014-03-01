class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.decimal :price
      t.belongs_to :merchant

      t.timestamps
    end
  end
end
