require 'test_helper'
require 'factory_bot'


class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    genre = create(:genre)
    get genres_url
    assert_response :success
  end

  test "should get show" do
    genre = create(:genre)
    get genre_url(genre)
    assert_response :success
  end
end
