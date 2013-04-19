# -*- encoding : utf-8 -*-
class RecrutamentoController < ApplicationController
  
  before_filter :recr_belongsTo_comite?, :only =>[:show]


  def recrutamento_membros
    @recrutamentos = Recrutamento.where("comite_id = ? and tipo = ?",current_comite.id,1)
    @recr_activo = @recrutamentos.recrutamento_activo(1)
  end

  def recrutamento_estagios
    @recrutamentos = Recrutamento.where("comite_id = ? and tipo = ?",current_comite.id,2)
    @recr_activo = @recrutamentos.recrutamento_activo(2)
  end


  def abrir_recrutamento_m
  	tipo = params[:tipo].to_i   									           #tipo=1 é pra membros e tipo=2 é pra estagios
  	@comite = Comite.find(current_comite)  			             #seleciona o comite pelo o id que esta no request

  	if !@comite.recrutamento.recrutamento_activo(tipo).nil?  #quando não existe nenhum recrutamento activo
  		r = @comite.recrutamento.recrutamento_activo(tipo)
  		r.fecha_inscricao
  	end

  	@recrutamento = Recrutamento.new(estado: true,tipo: tipo, comite_id: @comite.id) #cria o novo recrutamento

  	if @recrutamento.save
                      
	    @formulario = @comite.formularios.formulario_activo(tipo)       #vai buscar o formulario que esta activo de membros
	    
	    @formulario_novo  = @comite.cria_formulario(tipo,@comite.id,@recrutamento.id)
	    @formulario_novo.save  

	    if !@formulario.nil?

		    @formulario.estado = 0                                     #altera o estado do formulario antigo outro para 0
		    @formulario.save
		    
		    @formulario.pergunta_forms.each do |p|                         # copia todas as perguntas do formulario antigo para o novo
		      p = @formulario_novo.pergunta_forms.build(perguntum_id:p.perguntum_id,ordem:p.ordem,obrigatoria:p.obrigatoria)
		      p.save
	   		 end

		end                                                            #salva o formulario antigo
	    
	    @formulario_novo.save                                    #guarda o formulario novo

      #cria um novo contador
      counter = Counter.new(:visitas => 0, :recrutamento_id => @recrutamento.id )
      #counter = Counter.my_find(current_comite.id,tipo)
      counter.save

      #para saber para onde redirecionar
      path = path_redirect_formulario(tipo)
      

	    respond_to do |format|
	      format.html { redirect_to path }
	      format.json { head :no_content }
	    end
	  end
  end


  def abrir_inscricoes
  	tipo = params[:tipo].to_i   									   #tipo=1 é pra membros e tipo=2 é pra estagios
  	@comite = Comite.find(current_comite.id)  			   				   #seleciona o comite pelo o id que esta no request

  	@recrutamento = @comite.recrutamento.recrutamento_activo(tipo)			   #cria o novo recrutamento
  	@recrutamento.abre_inscricao

    path = path_redirect_formulario(tipo)

  	respond_to do |format|
	      format.html { redirect_to path }
	      format.json { head :no_content }
	  end
  end

  def fechar_inscricoes
    tipo = params[:tipo].to_i                        #tipo=1 é pra membros e tipo=2 é pra estagios
    @comite = Comite.find(current_comite.id)                     #seleciona o comite pelo o id que esta no request

    @recrutamento = @comite.recrutamento.recrutamento_activo(tipo)         #cria o novo recrutamento
    @recrutamento.fecha_inscricao

    respond_to do |format|
        format.html { redirect_to profile_path }
        format.json { head :no_content }
    end
  end

  def show

  	@recrutamento = Recrutamento.find(params[:id])
    @candidatos = @recrutamento.candidatos
    
    @counter = Counter.my_find(@recrutamento.id)

    if  !@counter.nil?
      stats = @recrutamento.viewEinscricoes(@counter)
      @h = column_plot1(stats,"Visitas vs Inscrições")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recrutamento }
    end
  end

  

end
