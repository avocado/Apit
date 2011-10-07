require 'test_helper'

class CaptainsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:captains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create captain" do
    assert_difference('Captain.count') do
      post :create, :captain => { }
    end

    assert_redirected_to captain_path(assigns(:captain))
  end

  test "should show captain" do
    get :show, :id => captains(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => captains(:one).to_param
    assert_response :success
  end

  test "should update captain" do
    put :update, :id => captains(:one).to_param, :captain => { }
    assert_redirected_to captain_path(assigns(:captain))
  end

  test "should destroy captain" do
    assert_difference('Captain.count', -1) do
      delete :destroy, :id => captains(:one).to_param
    end

    assert_redirected_to captains_path
  end
end
