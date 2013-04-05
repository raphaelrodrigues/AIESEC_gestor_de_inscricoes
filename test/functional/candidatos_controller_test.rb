# -*- encoding : utf-8 -*-
require 'test_helper'

class CandidatosControllerTest < ActionController::TestCase
  setup do
    @candidato = candidatos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:candidatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create candidato" do
    assert_difference('Candidato.count') do
      post :create, candidato: { comite_id: @candidato.comite_id, data_nascimento: @candidato.data_nascimento, nome: @candidato.nome, recrutamento_id: @candidato.recrutamento_id, telemovel: @candidato.telemovel, tipo: @candidato.tipo }
    end

    assert_redirected_to candidato_path(assigns(:candidato))
  end

  test "should show candidato" do
    get :show, id: @candidato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @candidato
    assert_response :success
  end

  test "should update candidato" do
    put :update, id: @candidato, candidato: { comite_id: @candidato.comite_id, data_nascimento: @candidato.data_nascimento, nome: @candidato.nome, recrutamento_id: @candidato.recrutamento_id, telemovel: @candidato.telemovel, tipo: @candidato.tipo }
    assert_redirected_to candidato_path(assigns(:candidato))
  end

  test "should destroy candidato" do
    assert_difference('Candidato.count', -1) do
      delete :destroy, id: @candidato
    end

    assert_redirected_to candidatos_path
  end
end
