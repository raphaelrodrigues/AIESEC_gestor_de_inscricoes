class ComitesController < ApplicationController
  # GET /comites
  # GET /comites.json

  skip_before_filter :authorize, :only => [:new,:create]
  before_filter :correct_comite, :only => [ :edit, :destroy]

  def index
    @comites = Comite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comites }
    end
  end

  # GET /comites/1
  # GET /comites/1.json
  def show
    @comite = !params[:id].nil? ? Comite.find(params[:id]) : current_comite

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comite }
    end
  end

  #metodo que guarda a ordem das perguntas 
  #com o drag&drop podemos alterar a sua ordem
  #no javascript é lancado um pedido para para executar este metodo
  #o js manda um array com os valores dos id' s das perguntas
  #ex params[:respostas]=[2,4,5]
  #ele vai a cada uma das perguntas e altera a sua ordem
  def reorder
    perguntas_ids = params[:perguntas]
    n = 1
    ActiveRecord::Base.transaction do
      perguntas_ids.each do |id|
        if !id.blank?
          pergunta = PerguntaForm.find(id)
          pergunta.ordem = n
          pergunta.save
          n += 1
        end
      end
    end
    render :json => {}
  end

  #formularios membros tipo = 1
  #/formulario_membros/:id para ver o formulario de um comite
  def formulario_membros
    
    @comites = Comite.find(:all,:select=>"id,nome")                #select id,nome from ...
    @comite = Comite.find_by_id(params[:id])                       #seleciona o comite pelo o id que esta no request
    
    @formulario = @comite.formularios.formulario_activo(1)         #vai buscar o formulario que esta activo

    @recrutamento = @formulario.recrutamento  unless  @formulario.nil?
    
  end

  #formularios estagios tipo = 2
  #/formulario_estagio/:id para ver o formulario de um comite
  def formulario_estagios
    @comites = Comite.find(:all,:select=>"id,nome")                #select id,nome from ...
    @comite = Comite.find_by_id(params[:id])                       #seleciona o comite pelo o id que esta no request
    
    @formulario = @comite.formularios.formulario_activo(2)         #vai buscar o formulario que esta activo de estagio que é o 2
    @recrutamento = @formulario.recrutamento  unless  @formulario.nil?
 
  end

  #serve para abrir um recrutamento e criar novos formularios
  def abrir_recrutamento

    tipo = params[:tipo].to_i                                         #tipo=1 é pra membros e tipo=2 é pra estagios
    @comite = Comite.find_by_id(params[:id])                          #seleciona o comite pelo o id que esta no request
    @formulario = @comite.formularios.formulario_activo(tipo)         #vai buscar o formulario que esta activo de membros
    
    if tipo == 1
      @formulario_membro_novo  = @comite.formularios.build(:nome=>"Formulario Membros",:comite_id=> @comite.id,:tipo=>1)
    else
      @formulario_membro_novo  = @comite.formularios.build(:nome=>"Formulario Estagios",:comite_id=> @comite.id,:tipo=>2)
    end

    if !@formulario.nil?
      @formulario.estado = 0                                         #altera o estado do formulario antigo outro para 0
      @formulario.save  
    end                                             #salva o formulario antigo
    
    @formulario_membro_novo.save                                   #guarda o formulario novo


    @formulario.pergunta_forms.each do |p|                         # copia todas as perguntas do formulario antigo para o novo
      p = @formulario_membro_novo.pergunta_forms.build(pergunta_id:p.pergunta_id,ordem:p.ordem,obrigatoria:p.obrigatoria)
      p.save
    end
    
    @formulario_membro_novo.save                                    #guarda o formulario novo

    respond_to do |format|
      format.html { redirect_to formulario_membros_path(@comite.id) }
      format.json { head :no_content }
    end

  end


  def survey
    @comite = Comite.find(params[:id])
    @formulario = @comite.formularios[0]
    @perguntas = @formulario.perguntum
    @form_id = @formulario.id

  end



 
  def guardar
      val = params[:respostas]
      @comite = Comite.find(params[:id])
      @formulario = @comite.formularios[0]
      @perguntas = @formulario.perguntum

      n = 0
      @perguntas.each do |p|
        Respostum.new(pergunta_id:params[:respostas][:id][n],resposta:params[:respostas][:resposta][n]).save
        n = n + 1
      end

      respond_to do |format|
      format.html { redirect_to resposta_path }
      format.json { head :no_content }
    end
  end


  def inscricoes

  end

  def help
  end

  def dashboard
  end
  
  # GET /comites/new
  # GET /comites/new.json
  def new
    @comite = Comite.new
    render :layout =>"sign_up"
    
  end

  # GET /comites/1/edit
  def edit
    @comite = Comite.find(params[:id])
  end

  # POST /comites
  # POST /comites.json
  def create
    @comite = Comite.new(params[:comite])

    respond_to do |format|
      if @comite.save
         format.html { redirect_to log_in, notice: 'Comite was successfully created.' }
            format.json { render json: @comite, status: :created, location: log_in }
      else
        format.html { render action: "new" }
        format.json { render json: @comite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comites/1
  # PUT /comites/1.json
  def update
    @comite = Comite.find(params[:id])

    respond_to do |format|
      if @comite.update_attributes(params[:comite])
        format.html { redirect_to @comite, notice: 'Comite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comites/1
  # DELETE /comites/1.json
  def destroy
    @comite = Comite.find(params[:id])
    @comite.destroy

    respond_to do |format|
      format.html { redirect_to comites_url }
      format.json { head :no_content }
    end
  end
end
