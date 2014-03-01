class Merchant < ActiveRecord::Base
	has_many :items
	has_many :purcahses, through :items
end
