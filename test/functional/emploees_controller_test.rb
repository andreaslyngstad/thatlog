require 'test_helper'

class EmploeesControllerTest < ActionController::TestCase
  setup do
    @emploee = emploees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emploees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emploee" do
    assert_difference('Emploee.count') do
      post :create, :emploee => @emploee.attributes
    end

    assert_redirected_to emploee_path(assigns(:emploee))
  end

  test "should show emploee" do
    get :show, :id => @emploee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @emploee.to_param
    assert_response :success
  end

  test "should update emploee" do
    put :update, :id => @emploee.to_param, :emploee => @emploee.attributes
    assert_redirected_to emploee_path(assigns(:emploee))
  end

  test "should destroy emploee" do
    assert_difference('Emploee.count', -1) do
      delete :destroy, :id => @emploee.to_param
    end

    assert_redirected_to emploees_path
  end
end
