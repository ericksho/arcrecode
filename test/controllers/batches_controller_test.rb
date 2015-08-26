require 'test_helper'

class BatchesControllerTest < ActionController::TestCase
  setup do
    @batch = batches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batch" do
    assert_difference('Batch.count') do
      post :create, batch: { daily_batch: @batch.daily_batch, description: @batch.description, elaboration_date: @batch.elaboration_date, intern_use_1: @batch.intern_use_1, intern_use_2: @batch.intern_use_2, lifespan: @batch.lifespan, verify_digit: @batch.verify_digit }
    end

    assert_redirected_to batch_path(assigns(:batch))
  end

  test "should show batch" do
    get :show, id: @batch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @batch
    assert_response :success
  end

  test "should update batch" do
    patch :update, id: @batch, batch: { daily_batch: @batch.daily_batch, description: @batch.description, elaboration_date: @batch.elaboration_date, intern_use_1: @batch.intern_use_1, intern_use_2: @batch.intern_use_2, lifespan: @batch.lifespan, verify_digit: @batch.verify_digit }
    assert_redirected_to batch_path(assigns(:batch))
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete :destroy, id: @batch
    end

    assert_redirected_to batches_path
  end
end
