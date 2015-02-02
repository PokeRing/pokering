require 'test_helper'

class ApiV1CommentsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::CommentsController.new
  end

  test "GET /comments" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /comments" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"parent_type": "games", "parent_id": 1, "comment": "Well Hello"}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /comments/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /comments/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"comment": "Well Hello UPDATED"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

  test "Forbidden PUT /comments/:id" do
    user = 'mbrech23839'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"comment": "Comment UPDATED attempt"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response(403)
  end

end
