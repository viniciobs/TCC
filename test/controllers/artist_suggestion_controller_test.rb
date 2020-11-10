require 'test_helper'

class ArtistSuggestionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_suggestion_index_url
    assert_response :success
  end

  test "should get create" do
    get artist_suggestion_create_url
    assert_response :success
  end

  test "should get destroy" do
    get artist_suggestion_destroy_url
    assert_response :success
  end

end
