require 'test_helper'

class ApiV1RequestsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::RequestsController.new
  end

  test "GET /requests" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /requests" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"parent_type": "games", "parent_id": 1, "request_type": "invite"}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /requests/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /requests/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"status": "inactive"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

end
