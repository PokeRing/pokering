require 'test_helper'

class ApiV1TripsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::TripsController.new
  end

  test "GET /trips" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /trips" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"location": "New York New York, las vegas, nv", "arrival_date": "2015-05-01T06:00:00Z", "departure_date": "2015-05-10T10:00:00Z", "is_chop_room": true, "max_players": 2, "players": [], "notify_rings": false}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /trips/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /trips/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"location": "MGM Grand, Las Vegas, NV"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

end
