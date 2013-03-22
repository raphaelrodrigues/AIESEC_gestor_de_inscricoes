require 'test_helper'

class PerguntaFormsControllerTest < ActionController::TestCase
  setup do
    @pergunta_form = pergunta_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pergunta_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pergunta_form" do
    assert_difference('PerguntaForm.count') do
      post :create, pergunta_form: { formulario_id: @pergunta_form.formulario_id, obrigatoria: @pergunta_form.obrigatoria, ordem: @pergunta_form.ordem, pergunta_id: @pergunta_form.pergunta_id }
    end

    assert_redirected_to pergunta_form_path(assigns(:pergunta_form))
  end

  test "should show pergunta_form" do
    get :show, id: @pergunta_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pergunta_form
    assert_response :success
  end

  test "should update pergunta_form" do
    put :update, id: @pergunta_form, pergunta_form: { formulario_id: @pergunta_form.formulario_id, obrigatoria: @pergunta_form.obrigatoria, ordem: @pergunta_form.ordem, pergunta_id: @pergunta_form.pergunta_id }
    assert_redirected_to pergunta_form_path(assigns(:pergunta_form))
  end

  test "should destroy pergunta_form" do
    assert_difference('PerguntaForm.count', -1) do
      delete :destroy, id: @pergunta_form
    end

    assert_redirected_to pergunta_forms_path
  end
end
