require 'test_helper'

class JobvideosControllerTest < ActionController::TestCase
  setup do
    @jobvideo = jobvideos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobvideos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobvideo" do
    assert_difference('Jobvideo.count') do
      post :create, :jobvideo => @jobvideo.attributes
    end

    assert_redirected_to jobvideo_path(assigns(:jobvideo))
  end

  test "should show jobvideo" do
    get :show, :id => @jobvideo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @jobvideo.to_param
    assert_response :success
  end

  test "should update jobvideo" do
    put :update, :id => @jobvideo.to_param, :jobvideo => @jobvideo.attributes
    assert_redirected_to jobvideo_path(assigns(:jobvideo))
  end

  test "should destroy jobvideo" do
    assert_difference('Jobvideo.count', -1) do
      delete :destroy, :id => @jobvideo.to_param
    end

    assert_redirected_to jobvideos_path
  end
end
