# -*- encoding : utf-8 -*-
class PerguntaFormsController < ApplicationController

  include PerguntaFormsHelper
  before_filter :pergunta_belongsTo_comite?, :only =>[:edit,:destroy]
  # GET /pergunta_forms
  # GET /pergunta_forms.json
  def index #retirar
    @pergunta_forms = PerguntaForm.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pergunta_forms }
    end
  end

  # GET /pergunta_forms/1
  # GET /pergunta_forms/1.json
  def show
    @pergunta_form = PerguntaForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pergunta_form }
    end
  end
  
  # GET /pergunta_forms/new
  # GET /pergunta_forms/new.json
  def new
    @pergunta_form = PerguntaForm.new
    @comite = Comite.find(current_comite)
    @formulario = @comite.formularios.where('estado = 1 and tipo = 1')[0]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pergunta_form }
    end
  end
  

  # altera propriedades das perguntas de um formulario
  # para esta action é passado como argumentos as comboxbox
  # que foram selecionadas nos formulario
  # para cada uma delas é feita a accao que se deseja
  def edit_pergunta_form
    if !params[:perguntas].nil?
      val = params[:perguntas]

      case params[:commit]
        when "Remover"
          # do something
           val.each do |v|
              pergunta_form = PerguntaForm.find(v)
              pergunta_form.destroy
              pergunta_form.save
           end

        when "Obrigatoria"
            # do something else
             val.each do |v|
                pergunta_form = PerguntaForm.find(v)
                pergunta_form.obrigatoria = true
                pergunta_form.save
             end
        
        when  "Opcional"
          val.each do |v|
                pergunta_form = PerguntaForm.find(v)
                pergunta_form.obrigatoria = false
                pergunta_form.save
             end


        when "Import"
            val.each do |v|
                pergunta_form = PerguntaForm.find(v)
                pergunta_form.obrigatoria = false
                pergunta_form.save
             end

        when "Export"
           @formulario = Comite.find_by_id(current_comite.id).formularios.formulario_activo(1)

           val.each do |v|
                pergunta_exp = PerguntaForm.find(v)
                pergunta_importada = PerguntaForm.new(perguntum_id:pergunta_exp.perguntum_id,ordem:get_ultima_ordem(@formulario.id),obrigatoria:pergunta_exp.obrigatoria,formulario_id:@formulario.id)
                pergunta_importada.save
            end
      end
    end


    respond_to do |format|
      format.html { redirect_to  formulario_membros_path(current_comite.id)}
      format.json { head :no_content }
    end

  end

  # GET /pergunta_forms/1/edit
  def edit
    @pergunta_form = PerguntaForm.find(params[:id])
  end

  # POST /pergunta_forms
  # POST /pergunta_forms.json
  def create
    @pergunta_form = PerguntaForm.new(params[:pergunta_form])

    respond_to do |format|
      if @pergunta_form.save
        format.html { redirect_to @pergunta_form, notice: 'Pergunta form was successfully created.' }
        format.json { render json: @pergunta_form, status: :created, location: @pergunta_form }
      else
        format.html { render action: "new" }
        format.json { render json: @pergunta_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pergunta_forms/1
  # PUT /pergunta_forms/1.json
  def update
    @pergunta_form = PerguntaForm.find(params[:id])

    respond_to do |format|
      if @pergunta_form.update_attributes(params[:pergunta_form])
        format.html { redirect_to @pergunta_form, notice: 'Pergunta form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pergunta_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pergunta_forms/1
  # DELETE /pergunta_forms/1.json
  def destroy
    @pergunta_form = PerguntaForm.find(params[:id])
    @pergunta_form.destroy

    respond_to do |format|
      format.html { redirect_to pergunta_forms_url }
      format.json { head :no_content }
    end
  end
end
