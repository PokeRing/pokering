require 'test_helper'

class ApiV1GamesControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::GamesController.new
  end

  test "GET /games" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :index
    assert_response :success
  end

  test "POST /games" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    headers = { 'Content-Type' => 'application/json' }
    json    = '{"name": "Game 2", "location": "124 3rd Ave Apt 3, New York, NY", "date": "2015-04-31 20:54:38", "base_game_type": "cash", "game_type": "holdem", "limit_type": "no-limit", "stakes": 1.5, "buy_in": 1.5, "re_buy_in": 1.5, "buy_in_min": 1.5, "buy_in_max": 1.5, "min_players": 1, "max_players": 1, "players": "[3,6]", "info": "YO YO YO"}'
    post :create, json, headers
    assert_response :success
  end

  test "GET /games/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    get :show, {:id => 1}
    assert_response :success
  end

  test "PUT /games/:id" do
    user = 'wpestler'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"name": "Game 1 UPDATED"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response :success
  end

  test "Forbidden PUT /games/:id" do
    user = 'mbrech23839'
    pw = '1234'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    json    = '{"name": "Game 1 UPDATED"}'
    raw_put :update, {:id => 1, 'Content-Type' => 'application/json'}, json
    assert_response(403)
  end

end
