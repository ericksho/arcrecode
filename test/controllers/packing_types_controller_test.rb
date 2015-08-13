require 'test_helper'

class PackingTypesControllerTest < ActionController::TestCase
  setup do
    @packing_type = packing_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packing_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create packing_type" do
    assert_difference('PackingType.count') do
      post :create, packing_type: { amount: @packing_type.amount, code: @packing_type.code, measure: @packing_type.measure }
    end

    assert_redirected_to packing_type_path(assigns(:packing_type))
  end

  test "should show packing_type" do
    get :show, id: @packing_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @packing_type
    assert_response :success
  end

  test "should update packing_type" do
    patch :update, id: @packing_type, packing_type: { amount: @packing_type.amount, code: @packing_type.code, measure: @packing_type.measure }
    assert_redirected_to packing_type_path(assigns(:packing_type))
  end

  test "should destroy packing_type" do
    assert_difference('PackingType.count', -1) do
      delete :destroy, id: @packing_type
    end

    assert_redirected_to packing_types_path
  end
end
