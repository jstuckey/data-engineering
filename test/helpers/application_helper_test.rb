require 'test_helper'

include ApplicationHelper

class ApplicationHelperTest < ActionView::TestCase

	setup do

		@file1 = Rails.root.join('test', 'fixtures', 'files', 'test1.tab')
		@file2 = Rails.root.join('test', 'fixtures', 'files', 'test2.tab')
		@file3 = Rails.root.join('test', 'fixtures', 'files', 'test3.tab')
		@bad_file = Rails.root.join('test', 'fixtures', 'files', 'bad_file.tab')

	end

	test "file parsing results" do

		results = parse_uploaded_file(@file1)

		record_count = results[:record_count]
      	error_count = results[:error_count]
      	purchase_ids = results[:purchase_ids]

      	assert_equal 1, record_count, "The record count should be 1"
      	assert_equal 0, error_count, "The error count should be 0"
      	assert_equal 1, purchase_ids.length, "Purchase ID count should be 1"

      	# -----------

      	results = parse_uploaded_file(@file2)

		record_count = results[:record_count]
      	error_count = results[:error_count]
      	purchase_ids = results[:purchase_ids]

      	assert_equal 4, record_count, "The record count should be 4"
      	assert_equal 0, error_count, "The error count should be 0"
      	assert_equal 4, purchase_ids.length, "Purchase ID count should be 4"

      	# -----------

      	results = parse_uploaded_file(@file3)

		record_count = results[:record_count]
      	error_count = results[:error_count]
      	purchase_ids = results[:purchase_ids]

      	assert_equal 28, record_count, "The record count should be 28"
      	assert_equal 0, error_count, "The error count should be 0"
      	assert_equal 28, purchase_ids.length, "Purchase ID count should be 28"

      	# -----------

  #     	results = parse_uploaded_file(@bad_file)

		# record_count = results[:record_count]
  #     	error_count = results[:error_count]
  #     	purchase_ids = results[:purchase_ids]

  #     	assert_equal 0, record_count, "The record count should be 0"
  #     	assert_equal 3, error_count, "The error count should be 3"
  #     	assert_equal 0, purchase_ids.length, "Purchase ID count should be 0"


	end

	test "create customer" do

		# No customer should exist yet
		customer = Customer.find_by( name: "Snake Plissken" )
		assert customer.nil?, "This customer should not exist yet"

		# Check total customer count
		assert_equal 0, Customer.count, "No customers should exist yet"

		# Upload the test file
		parse_uploaded_file(@file1)

		# Check that customer was added
		customers = Customer.where( name: "Snake Plissken" )
		refute customers.nil?, "A customer should have been added"
		refute customers.first.nil?, "A customer should have been added"
		assert_equal 1, customers.count, "Only one customer should have been added"

		customer = customers.first
		assert_equal "Snake Plissken", customers.first.name, "Customer name does not match"
		assert_equal 1, customer.purchases.count, "Customer's purchase count does not match"

		# Upload the test file again
		parse_uploaded_file(@file1)

		# Make sure a second customer was not added
		customers = Customer.where( name: "Snake Plissken" )
		refute customers.nil?, "A customer should exist"
		refute customers.first.nil?, "A customer should exist"
		assert_equal 1, customers.count, "A duplicate customer was added"

		# Another purchase should be added
		assert_equal 2, customer.purchases.count, "Customer's purchase count does not match"

		# Check total customer count
		assert_equal 1, Customer.count, "One customer should have been created"

	end

	test "create merchant" do

		# No merchant should exist yet
		merchant = Merchant.find_by( name: "Bob's Pizza" )
		assert merchant.nil?, "A merchant should not exist yet"

		# Check total merchant count
		assert_equal 0, Merchant.count, "No merchants should exist yet"

		# Upload the test file
		parse_uploaded_file(@file1)

		# Check that merchant was added
		merchants = Merchant.where( name: "Bob's Pizza" )
		refute merchants.nil?, "A merchant should have been added"
		refute merchants.first.nil?, "A merchant should have been added"
		assert_equal 1, merchants.count, "Only one merchant should have been added"

		merchant = merchants.first

		assert_equal "Bob's Pizza", merchant.name, "Merchant name does not match"
		assert_equal 1, merchant.items.count, "Merchant's item count does not match"

		item = merchant.items.first
		assert_equal "Pizza", item.description, "Item description does not match"
		assert_equal 8, item.price, "Item price does not match"

		# Upload the test file again
		parse_uploaded_file(@file1)

		# Make sure a second merchant was not added
		merchants = Merchant.where( name: "Bob's Pizza" )
		refute merchants.nil?, "A merchant should have been added"
		refute merchants.first.nil?, "A merchant should exist"
		assert_equal 1, merchants.count, "A merchant should exist"

		# Check total merchant count
		assert_equal 1, Merchant.count, "One merchant should have been created"

	end

	test "create item" do

		# No item should exist yet
		item = Item.find_by( description: "Pizza" )
		assert item.nil?, "An item should not exist yet"

		# Check total item count
		assert_equal 0, Item.count, "No items should exist yet"

		# Upload the test file
		parse_uploaded_file(@file1)

		# Check that item was added
		items = Item.where( description: "Pizza" )
		refute items.nil?, "An item should have been added"
		refute items.first.nil?, "An item should have been added"
		assert_equal 1, items.count, "Only one item should have been added"

		item = items.first
		assert_equal "Pizza", item.description, "Item description does not match"
		assert_equal 8, item.price, "Item price does not match"

		refute item.merchant.nil?, "Item should belong to a merchant"
		assert_equal "Bob's Pizza", item.merchant.name, "Item's merchant name does not match"

		# Upload the test file again
		parse_uploaded_file(@file1)

		# Make sure a second item was not added
		items = Item.where( description: "Pizza" )
		refute items.nil?, "An item should have been added"
		refute items.first.nil?, "An item should exist"
		assert_equal 1, items.count, "An item should exist"

		# Check total item count
		assert_equal 1, Item.count, "One item should have been created"

	end

	test "create purchase" do

		# Check total purchase count
		assert_equal 0, Purchase.count, "No purchases should exist yet"

		# Upload the test file
		parse_uploaded_file(@file1)

		# Check that purchase was added
		purchases = Purchase.all
		refute purchases.nil?, "A purchase should have been added"
		refute purchases.first.nil?, "A purchase should have been added"

		purchase = purchases.first

		assert_equal 2, purchase.count, "Purchase count does not match"
		assert_equal 1, purchase.items.count, "Purchase's item count does not match"

		item = purchase.items.first
		assert_equal "Pizza", item.description, "Item description does not match"
		assert_equal 8, item.price, "Item price does not match"

		refute purchase.customer.nil?, "Purchase should belong to a customer"
		assert_equal "Snake Plissken", purchase.customer.name, "Purchase's customer name does not match"

		# Upload the test file again
		parse_uploaded_file(@file1)

		# Make sure a second purchase was not added
		purchases = Purchase.where( description: "Pizza" )
		refute purchases.nil?, "Purchases should have been added"
		assert_equal 2, Purchase.count, "Two purchases should have been created"

	end

end
