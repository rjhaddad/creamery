require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
setup do
    create_stores
  end

  teardown do
    remove_stores
  end


  test "should get index" do
    get stores_url
    assert_response :success
  end

  test "should get new" do
    get new_store_url
    assert_response :success
  end


  test "should create a new store" do
    assert_difference('Store.count') do
      post stores_url, params: { store: { active: @cmu.active, city: @cmu.city, name: "Porter", phone: "4122683259", state: @cmu.state, street: @cmu.street, zip: @cmu.zip } }
    end

  end


  test "should get edit" do
    get edit_store_url(@cmu)
    assert_response :success
  end


  test "should update a store" do
    patch store_url(@cmu), params: { store: { active: @cmu.active, city: @cmu.city, name: "Porter", phone: "4122683259", state: @cmu.state, street: @cmu.street, zip: @cmu.zip } }
    assert_redirected_to store_url(@cmu)
  end

  test "should destroy store" do
    ## Because we no longer destroy stores, just make them inactive, these tests are different than phase 3
    assert_difference('Store.count', -1) do
      delete store_url(@cmu)
    end
  end
  
end

