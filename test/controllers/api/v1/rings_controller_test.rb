require 'test_helper'

class ApiV1RingsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::RingsController.new
  end

  test "GET /rings" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /rings" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"title": "Pokering 3"}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /rings/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /rings/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"title": "Pokering 1 UPDATED"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

end
