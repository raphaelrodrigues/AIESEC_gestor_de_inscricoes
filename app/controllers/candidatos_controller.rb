class CandidatosController < ApplicationController

before_filter :cand_belongsTo_comite?, :only =>[:show]  
  # GET /candidatos
  # GET /candidatos.json
  def index

    recrutamento = current_comite.recrutamento.recrutamento_activo(1)                                              #vai buscar o recrutamento que esta activo
    @candidatos = recrutamento.candidatos.search(params[:search],params[:page])  #vai buscar os candidatos desse recrutamento

  end


  def candidatos_membros
   recrutamento = current_comite.recrutamento.recrutamento_activo(1)                                                        #vai buscar o recrutamento que esta activo
   @candidatos = recrutamento.candidatos.search(params[:search],params[:page]) unless  recrutamento.nil?    #vai buscar os candidatos desse recrutamento
   @estado = Estado.new
  end

  def candidatos_estagios
   recrutamento = current_comite.recrutamento.recrutamento_activo(2)                                     #vai buscar o recrutamento que esta activo
   @candidatos = recrutamento.candidatos.search(params[:search],params[:page])  unless  recrutamento.nil?  #vai buscar os candidatos desse recrutamento
  
  end

  # altera propriedades das perguntas de um formulario
  # para esta action é passado como argumentos as comboxbox
  # que foram selecionadas nos formulario
  # para cada uma delas é feita a accao que se deseja
    # altera propriedades das perguntas de um formulario
  # para esta action é passado como argumentos as comboxbox
  # que foram selecionadas nos formulario
  # para cada uma delas é feita a accao que se deseja
  def edit_candidatos
    r = formulario_membros_path(current_comite.id)

    if !params[:candidatos].nil?
      val = params[:candidatos]
      case params[:commit]
          when "Import"
            r = formulario_membros_path(current_comite.id)
          when "Mudar Estado"
            val.each do |v|
                candidato = Candidato.find(v)
                params[:estado][:candidato_id] = v.to_i
                estado = candidato.estados.build(params[:estado])
                estado.save
             end
             r = candidatos_membros_path
      end

    end #fim do if
      respond_to do |format|
              format.html { redirect_to  r}
              format.json { head :no_content }
      end

    

  end


  # GET /candidatos/1
  # GET /candidatos/1.json
  def show
    @candidato = Candidato.find(params[:id])
    @estados = @candidato.estados

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @candidato }
    end
  end

  # GET /candidatos/new
  # GET /candidatos/new.json
  def new
    @candidato = Candidato.new
    @estado = Estado.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @candidato }
    end
  end

  #pagina onde o candidato
  # escolhe o comite e se é para estagio ou membro
  def inscricao
    @comites = Comite.all
    render :layout =>"survey"
  end

  def survey
    
    @comite = Comite.find(params[:cenas][:comite])
    @formulario = @comite.formularios.formulario_activo(params[:cenas][:tipo])

    if !@formulario.nil?
      @perguntas_form = @formulario.pergunta_forms
    end

    render :layout =>"survey"
  end

  #guardar respostas de um candidato
  def guardar_survey
     val = params[:respostas]
     @comite = Comite.find(params[:id])

     @formulario = @comite.formularios.formulario_activo(params[:tipo])
     @candidato = Candidato.novo(val,params[:tipo],@comite.id,@formulario.recrutamento.id) #cria um novo candidato

     @perguntas = @formulario.pergunta_forms             #vai buscar todas as perguntas do formulario
     
     n = 0
     if @candidato.save
       @perguntas.each do |p|
          Resposta.new(candidato_id: @candidato.id,pergunta_id:params[:respostas][:id][n],resposta:params[:respostas][:resposta][n],tipo: params[:tipo]).save
          n = n + 1
       end
     end

      respond_to do |format|
      format.html { redirect_to candidatos_path }
      format.json { head :no_content }
    end
  end

  # GET /candidatos/1/edit
  def edit
    @candidato = Candidato.find(params[:id])
    @estado = Estado.new
  end

  # POST /candidatos
  # POST /candidatos.json
  def create
    @candidato = Candidato.new(params[:candidato])

    respond_to do |format|
      if @candidato.save

        params[:estado][:candidato_id] = @candidato.id
        @estado = Estado.new(params[:estado]).save
        format.html { redirect_to @candidato, notice: 'Candidato was successfully created.' }
        format.json { render json: @candidato, status: :created, location: @candidato }
      else
        format.html { render action: "new" }
        format.json { render json: @candidato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /candidatos/1
  # PUT /candidatos/1.json
  def update
    @candidato = Candidato.find(params[:id])

    respond_to do |format|
      if @candidato.update_attributes(params[:candidato])
        format.html { redirect_to @candidato, notice: 'Candidato was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @candidato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidatos/1
  # DELETE /candidatos/1.json
  def destroy
    @candidato = Candidato.find(params[:id])
    @candidato.destroy

    respond_to do |format|
      format.html { redirect_to candidatos_url }
      format.json { head :no_content }
    end
  end
end