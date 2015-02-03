require 'test_helper'

class ApiV1InvitesControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::InvitesController.new
  end

  test "GET /invites" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /invites" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"parent_type": "games", "parent_id": 1, "invited_id": 3}'
    post :create, json, headers
    assert_response :success

    # make sure this generated a new notification
    notification = Notification.find(Notification.maximum('id'))
    assert_equal 'invite.created', notification.type_id
    assert_equal 3, notification.to_id
    assert_equal 'unread', notification.status
  end

  test "GET /invites/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /invites/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"status": "declined"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

end
