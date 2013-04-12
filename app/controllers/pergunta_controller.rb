# -*- encoding : utf-8 -*-
class PerguntaController < ApplicationController
  
  before_filter :pergunta_belongsTo_comite?, :only =>[:edit,:destroy]
  # GET /pergunta
  # GET /pergunta.json
  def index
    @perguntas = Perguntum.where("activa = true") #apenas devolve as que estao activas

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pergunta }
    end
  end

  # GET /pergunta/1
  # GET /pergunta/1.json
  def show
    @perguntum = Perguntum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @perguntum }
    end
  end

  # GET /pergunta/new
  # GET /pergunta/new.json
  def new
    @perguntum = Perguntum.new                              
    @pergunta_form = PerguntaForm.new
    @comite = Comite.find(current_comite)                      #procura o comite onde a quem a pergunta vai pertencer
    

    if params[:name] == "form_membro"                           #como existem 2 formularios a nova pergunta pode ser criada 
      @formulario = @comite.formularios.formulario_activo(1)    # em ambas.esta condicao serve para saber de onde ela vem,
    else                                                        # se vem do form_membros ou form_estagio
       @formulario = @comite.formularios.formulario_activo(2)   # para saber isso é passado como parametro um tipo
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @perguntum }
    end
  end

  # GET /pergunta/1/edit
  def edit
    @perguntum = Perguntum.my_find(params[:id])
    @pergunta_form = @perguntum.pergunta_forms
  end


  #perguntas do comites
  def perguntas_comite
    @comites = Comite.find(:all,:select=>"id,nome")
    @perguntas = Perguntum.where("comite_id = ? and activa = true",params[:id])
    

  end

  # quando se esta na lista das perguntas dos comites
  # é possivel importar perguntas para os formularios
  # pode-se importar para o formulario de membro e estagio
  # tem de existir um formulario activo para funcionar.
  def importar_pergunta_form
    if !params[:perguntas].nil?
      val = params[:perguntas]

      case params[:commit]
        when "Add Form. Membros"
            tipo = 1
        when "Add Form. Estagios"
            tipo = 2
      end

      @formulario = Comite.find_by_id(current_comite.id).formularios.formulario_activo(tipo)
      if !@formulario.nil?                            #verifica se formulario existe e esta activo
             val.each do |v|
                  pergunta_exp = Perguntum.find(v)
                  pergunta_importada = PerguntaForm.new(perguntum_id:pergunta_exp.id,ordem:get_ultima_ordem(@formulario.id),obrigatoria:false,formulario_id:@formulario.id)
                  pergunta_importada.save
              end
      end
    end
      respond_to do |format|
        format.html { redirect_to  formulario_membros_path(current_comite.id)}
        format.json { head :no_content }
      end
    
  end


  # POST /pergunta
  # POST /pergunta.json
  def create
    op = params[:perguntum][:opcoes]
    str = concat_options(op)
    options = ""
    if params[:perguntum][:tipo] != 1
      options = str
    end 

    params[:perguntum][:opcoes] = options
    

    @perguntum = Perguntum.new(params[:perguntum])

    respond_to do |format|
      if @perguntum.save 
        params[:pergunta_form][:perguntum_id] = @perguntum.id                    #ao ser criada uma pergunta normal é preciso
        @pergunta_form = PerguntaForm.new(params[:pergunta_form]).save          #criar uma sub-pergunta
        format.html { redirect_to @perguntum, notice: 'Perguntum was successfully created.' }
        format.json { render json: @perguntum, status: :created, location: @perguntum }
      else
        format.html { render action: "new" }
        format.json { render json: @perguntum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pergunta/1
  # PUT /pergunta/1.json
  def update
    @perguntum = Perguntum.find(params[:id])
    @pergunta_form = @perguntum.pergunta_forms
    respond_to do |format|
      if @perguntum.update_attributes(params[:perguntum])
        format.html { redirect_to @perguntum, notice: 'Perguntum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @perguntum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pergunta/1
  # DELETE /pergunta/1.json
  def destroy
    @perguntum = Perguntum.find(params[:id])
    @perguntum.activa = 0
    @perguntum.save

    respond_to do |format|
      format.html { redirect_to pergunta_url }
      format.json { head :no_content }
    end
  end
end
