class HomeController < ApplicationController
	include ApplicationHelper


  def index
  end

  def upload

    # Check if a file was uploaded
    file = params[:file]
  	if file and file.respond_to?(:read)

      # Get the file name
      file_name = file.path()

      # Parse the uploaded file
      results = parse_uploaded_file(file_name)

      # Return counts to the view
      @record_count = results[:record_count]
      @error_count = results[:error_count]


      # Return the most recent purchases to the view
      purchase_ids = results[:purchase_ids]
      @purchases = Purchase.find(purchase_ids)

      # Calculate the amount of gross revenue in the file
      @gross_revenue = @purchases.reduce(0) do |total, purchase|
        total + purchase.count * purchase.items.first.price
      end

    else
      render "index", notice: "Please select a file to upload."
  	end

  end

end
