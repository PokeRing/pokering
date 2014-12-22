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

end
