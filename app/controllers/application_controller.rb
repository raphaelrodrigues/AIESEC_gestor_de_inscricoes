class ApplicationController < ActionController::Base
  protect_from_forgery

  #para se poderem usar nas views
  helper_method :current_comite,:signed_in?,:getPergunta
  before_filter :authorize

  #verifica se está com login feito
  def signed_in?
	 !!current_comite
  end

  #para ir buscar a info da pergunta para aceder ao titulo a patir do id
  def getPergunta(id_pergunta)
    @pergunta = Perguntum.find(id_pergunta)
  end


  private
    #verifica se esta alguem logado e se estiver devolve o comite que esta logado
  	def current_comite
  	  @current_comite ||= Comite.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  	end

    #verifica se comite que tenta aceder é aquele que esta logado(para evitar que comites alterem outros)
    def correct_comite
      @comite = Comite.find(params[:id])
      redirect_to "/comites" unless @comite.id == current_comite.id
    end

    #verifica se um recrutamento pertence ao comite
    def recr_belongsTo_comite?
      @recrutamento = Recrutamento.find(params[:id])
      redirect_to "/recrutamento" unless @recrutamento.comite_id == current_comite.id
    end
    #verifica se um candidato pertence ao comite
    def cand_belongsTo_comite?
      @candidato = Candidato.find(params[:id])
      redirect_to "/candidatos" unless @candidato.comite_id == current_comite.id
    end

    #verifica se uma pergunta pertence ao comite
    def pergunta_belongsTo_comite?
      @perg = PerguntaForm.find(params[:id])
      redirect_to "/perguntas_comite/"+current_comite.id.to_s unless @perg.formulario.comite_id == current_comite.id
    end


    # ao inserir uma pergunta no formulario insere no fim 
    # funcao verifica qual a ultima posicao
    def get_ultima_ordem(id_formularios)
      ultima_pergunta = PerguntaForm.where(" formulario_id = ?",id_formularios).last 
      if !ultima_pergunta.nil?
        @ultima_ordem = ultima_pergunta.ordem + 1
      else
        #se ainda nao houver perguntas
        @ultima_ordem = 1
      end
    end
     
   protected
   	   # Checks that comite is logged in
  	  def authorize
  	    redirect_to "/log_in", :alert => t('.need_to_be_logged_in') unless signed_in?
  	  end
end
