require 'test_helper'

class JobcodesControllerTest < ActionController::TestCase
  setup do
    @jobcode = jobcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobcode" do
    assert_difference('Jobcode.count') do
      post :create, :jobcode => @jobcode.attributes
    end

    assert_redirected_to jobcode_path(assigns(:jobcode))
  end

  test "should show jobcode" do
    get :show, :id => @jobcode.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @jobcode.to_param
    assert_response :success
  end

  test "should update jobcode" do
    put :update, :id => @jobcode.to_param, :jobcode => @jobcode.attributes
    assert_redirected_to jobcode_path(assigns(:jobcode))
  end

  test "should destroy jobcode" do
    assert_difference('Jobcode.count', -1) do
      delete :destroy, :id => @jobcode.to_param
    end

    assert_redirected_to jobcodes_path
  end
end
