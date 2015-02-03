require 'test_helper'

class ApiV1NotificationsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::NotificationsController.new
  end

  test "GET /trips" do
    # not testing since sse-based
  end

  test "GET /notifications/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /notifications/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"status": "read", "type_id": "blah", "to_id": 1000, "content": "blah"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
    result = JSON.parse(@response.body)
    assert_equal "read", result["status"]
    assert_not_equal "blah", result['type_id']
    assert_not_equal 1000, result['to_id']
    assert_not_equal "blah", result['content']
  end

end
