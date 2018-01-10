require 'test_helper'
require 'pry'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  # test "should get show" do
  #   user = users(:one)
  #   get :show, id: user.id
  #   # binding.pry
  #   assert_response :success
  # end

end
