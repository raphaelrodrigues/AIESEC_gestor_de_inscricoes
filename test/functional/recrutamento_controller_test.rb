# -*- encoding : utf-8 -*-
require 'test_helper'

class RecrutamentoControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
