module ApplicationHelper
	def parse_uploaded_file(file_name)

		record_count = 0
		error_count = 0
		purchase_ids = Array.new

		File.open(file_name).each_with_index do |line, index|

			begin
				# Skip the column header
				# The spec says we can always assume a header line
				next if index == 0

				# Split the line delimited by tabs
				# The spec says the columns are always separated by tabs
				columns = line.split /\t/

				# Break each column into its own object
				# The spec says the columns are always in the same order and always present
				customer_name = columns[0]
				item_description = columns[1]
				item_price = columns[2]
				purchase_count = columns[3]
				merchant_address = columns[4]
				merchant_name = columns[5]

				# Convert these raw variables into Active Record models

				# Either fetch or create a customer based on his/her name
				customer = Customer.find_or_create_by( name: customer_name )

				# Either fetch or create a merchant based on its name
				merchant = Merchant.find_or_create_by( name: merchant_name ) do |new_merchant|
					# This block is called if creating a new merchant
					new_merchant.address = merchant_address
				end

				# Either fetch or create an item based on its description
				item = Item.find_or_create_by( description: item_description ) do |new_item|
					# This block is called if creating a new item
					new_item.price = item_price
					new_item.merchant = merchant
				end

				# Create a new purchase record
				purchase = Purchase.new({ count: purchase_count })

				# Add the item to the purchase's collection
				purchase.items << item

				# Add the purchase to the user's collection
				customer.purchases << purchase

				# Save the models
				customer.save
				merchant.save
				item.save
				purchase.save

				# Add to the array of purchase_ids so we can return them
				purchase_ids << purchase.id

				# Up the record count so we can return it
				record_count = record_count + 1

			rescue => e

				Rails.logger.error e

				# Up the error count so we can return it
				error_count = error_count + 1
			end

		end

		# Return a hash of upload information
		return { record_count: record_count, error_count: error_count, purchase_ids: purchase_ids }
	end
end
