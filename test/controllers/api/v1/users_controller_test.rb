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

end
