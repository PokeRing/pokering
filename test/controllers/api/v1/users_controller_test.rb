require 'test_helper'

class ApiV1UsersControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::UsersController.new
  end

  test "GET /users" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /users" do
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"email": "automatedtest@getpokering.com"}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /users/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /users/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"last_name": "PESTLER UPDATED"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
    result = JSON.parse(@response.body)
    assert_equal "PESTLER UPDATED", result['last_name']
    assert_equal "Walter", result['first_name']
  end

  test "Bad User Rating" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"rating": 1.5}'
    raw_put :ratings, {:id => 3, 'Content-Type' => 'application/json'}, json
    assert_response(400)
  end

  test "New User Rating" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"rating": 1}'
    raw_put :ratings, {:id => 3, 'Content-Type' => 'application/json'}, json
    assert_response :success
    # first make sure there's a record in user_ratings
    rating = UserRating.find_by(rating_user_id: 1, rated_user_id: 3)
    assert_not_nil rating
    assert_equal 1, rating.rating
    # now make sure the user record was updated
    rated = User.find_by(id: 3)
    assert_equal 1, rated.rating
  end

  test "User Rating Averaging" do
    user = 'bvermin'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"rating": 2}'
    raw_put :ratings, {:id => 2, 'Content-Type' => 'application/json'}, json
    assert_response :success
    rated = User.find_by(id: 2)
    assert_equal 2.5, rated.rating
  end

end
