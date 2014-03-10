require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  setup do
  	@file1 = fixture_file_upload('files/test1.tab','text/tab-separated-values')
  	@file2 = fixture_file_upload('files/test2.tab','text/tab-separated-values')
  	@file3 = fixture_file_upload('files/test3.tab','text/tab-separated-values')
  end

  test "should get upload" do

    post :upload, file: @file1
    assert_response :success

    record_count = assigns(:record_count)
    error_count = assigns(:error_count)
    purchases = assigns(:purchases)
    gross_revenue = assigns(:gross_revenue)

    assert_not_nil record_count
    assert_not_nil error_count
    assert_not_nil purchases
    assert_not_nil gross_revenue

    assert_equal 1, record_count
    assert_equal 0, error_count
    assert_equal 1, purchases.count
    assert_equal 16, gross_revenue

    # -----------

    post :upload, file: @file2
    assert_response :success

    record_count = assigns(:record_count)
    error_count = assigns(:error_count)
    purchases = assigns(:purchases)
    gross_revenue = assigns(:gross_revenue)

    assert_not_nil record_count
    assert_not_nil error_count
    assert_not_nil purchases
    assert_not_nil gross_revenue

    assert_equal 4, record_count
    assert_equal 0, error_count
    assert_equal 4, purchases.count
    assert_equal 95, gross_revenue

    # -----------

    post :upload, file: @file3
    assert_response :success

    record_count = assigns(:record_count)
    error_count = assigns(:error_count)
    purchases = assigns(:purchases)
    gross_revenue = assigns(:gross_revenue)

    assert_not_nil record_count
    assert_not_nil error_count
    assert_not_nil purchases
    assert_not_nil gross_revenue

    assert_equal 28, record_count
    assert_equal 0, error_count
    assert_equal 28, purchases.count
    assert_equal 665, gross_revenue


  end

end
