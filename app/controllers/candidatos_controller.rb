# -*- encoding : utf-8 -*-
class CandidatosController < ApplicationController

before_filter :cand_belongsTo_comite?, :only =>[:show,:edit,:destroy]  

skip_before_filter :authorize, :only => [:inscricao,:survey]


  def candidatos_membros
     recrutamento = current_comite.recrutamento.recrutamento_activo(1)                                                        #vai buscar o recrutamento que esta activo
     
     @candidatos = recrutamento.candidatos.search(params[:search],params[:page],params[:field]) unless  recrutamento.nil?    #vai buscar os candidatos desse recrutamento
     

     @estado = Estado.new
     @estados_recrut = EstadoRecrut.activos(1,current_comite.id)
     @tipo = 1

     if !recrutamento.nil?
       @stats = Candidato.percentagem_idades(recrutamento.id)
       @h = pie_plot(@stats,"Idade Candidatos")

       @stats1 = Candidato.est_candidatos(recrutamento)
       @h1 = pie_plot(@stats1,"Estados Candidatos")
     end
   
  end

  def candidatos_estagios
     recrutamento = current_comite.recrutamento.recrutamento_activo(2)                                     #vai buscar o recrutamento que esta activo
     @candidatos = recrutamento.candidatos.search(params[:search],params[:page],params[:field])  unless  recrutamento.nil?  #vai buscar os candidatos desse recrutamento
     
     @estado = Estado.new
     @estados_recrut = EstadoRecrut.activos(2,current_comite.id)
     @tipo = 2

     if !recrutamento.nil?
       @stats = Candidato.percentagem_idades(recrutamento.id)
       @h = pie_plot(@stats,"Idade Candidatos")

       @stats1 = Candidato.est_candidatos(recrutamento)
       @h1 = pie_plot(@stats1,"Estados Candidatos")
    end

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
    if params[:tipo] == 1
      r = candidatos_membros_path
    else
      r = candidatos_estagios_path
    end

    if !params[:candidatos].nil?
      val = params[:candidatos]
      case params[:commit]
          when "Mudar Estado"
            val.each do |v|
                candidato = Candidato.find(v)
                params[:estado][:candidato_id] = v.to_i
                estado = candidato.estados.build(params[:estado])
                estado.save
             end
             

          when "Enviar Mail"
            n =0
            val.each do |v|
              SendMail.mail_candidato(v,params[:mail],n).deliver
              n = n+1
            end
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
    
    @estado = Estado.new
    @estados_recrut = EstadoRecrut.activos(@candidato.tipo,current_comite.id)


    respond_to do |format|
      format.html # show.html.erb
      format.csv 
      format.xls  #{ send_data Candidato.to_csv({col_sep: "\t"},@candidato,@candidato.respostas) }
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
    @recrutamento = @comite.recrutamento.activo_and_aberto(params[:cenas][:tipo])

    if !@recrutamento.nil?
      @formulario = @comite.formularios.formulario_activo(params[:cenas][:tipo])
      Counter.conta(@recrutamento.id)
      if !@formulario.nil?
        @perguntas_form = @formulario.pergunta_forms
      end
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
     rsp = ""
     if @candidato.save
       @perguntas.each do |p|
            if val[p.perguntum_id.to_s].nil?
              rsp = "[Não Respondeu]"
            else
              rsp = val[p.perguntum_id.to_s][:resposta].to_sentence
            end

            Resposta.new(candidato_id: @candidato.id,pergunta_id:p.perguntum_id,resposta:rsp,tipo: params[:tipo]).save
            rsp = ""
      end
     end
     
      respond_to do |format|
      format.html { redirect_to survey_final_path }
      format.json { head :no_content }
    end
  end

  def survey_final
    render :layout =>"survey"
  end


  def candidatos_fora_epoca
    @candidatos = Candidato.fora_epoca(current_comite.id)
  end

  def guardar_cand_fora_epoca
      val = params[:respostas]
      comite_id = params[:id]
      tipo = params[:tipo]
      @candidato = Candidato.novo(val,tipo,comite_id,0) #cria um novo candidato

      @candidato.save

      respond_to do |format|
        format.html { redirect_to survey_final_path }
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
    @candidato.activo = 0

    @candidato.save

    respond_to do |format|
      format.html { redirect_to dashboard_path }
      format.json { head :no_content }
    end
  end
end
