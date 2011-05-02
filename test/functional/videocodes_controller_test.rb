require 'test_helper'

class VideocodesControllerTest < ActionController::TestCase
  setup do
    @videocode = videocodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videocodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create videocode" do
    assert_difference('Videocode.count') do
      post :create, :videocode => @videocode.attributes
    end

    assert_redirected_to videocode_path(assigns(:videocode))
  end

  test "should show videocode" do
    get :show, :id => @videocode.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @videocode.to_param
    assert_response :success
  end

  test "should update videocode" do
    put :update, :id => @videocode.to_param, :videocode => @videocode.attributes
    assert_redirected_to videocode_path(assigns(:videocode))
  end

  test "should destroy videocode" do
    assert_difference('Videocode.count', -1) do
      delete :destroy, :id => @videocode.to_param
    end

    assert_redirected_to videocodes_path
  end
end
