require 'test_helper'

class ConsumersControllerTest < ActionController::TestCase
  setup do
    @consumer = consumers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consumers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consumer" do
    assert_difference('Consumer.count') do
      post :create, consumer: { birthdate: @consumer.birthdate, firstname: @consumer.firstname, gender: @consumer.gender, lastname: @consumer.lastname }
    end

    assert_redirected_to consumer_path(assigns(:consumer))
  end

  test "should show consumer" do
    get :show, id: @consumer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consumer
    assert_response :success
  end

  test "should update consumer" do
    put :update, id: @consumer, consumer: { birthdate: @consumer.birthdate, firstname: @consumer.firstname, gender: @consumer.gender, lastname: @consumer.lastname }
    assert_redirected_to consumer_path(assigns(:consumer))
  end

  test "should destroy consumer" do
    assert_difference('Consumer.count', -1) do
      delete :destroy, id: @consumer
    end

    assert_redirected_to consumers_path
  end
end
