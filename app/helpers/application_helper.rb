module ApplicationHelper

	#verifica se está com login feito
  def signed_in?
	 !!current_comite
  end

  #metodos para gerir permissoes
  def correct_comite
    @comite = Comite.find(params[:id])
    redirect_to "/comites" unless @comite.id == current_comite.id
  end

  #para saber qual o tipo de formulario
  def tipo_formulario?(form_tipo) 
  	if form_tipo == 1
  		return "form_membro"
  	else
  		return "form_estagio"
    end
  end

  #mapeia o tipo para string
  def tipoToString( tipo )
    if tipo == 1
      return "Membros"
    else
      return "Estagios"
    end
  end

  #diz se inscriçoes estao abertas/fechadas a partir field activo
  # se activo==true return Abertas senao Fechadas
  def insc_abertas?(activo)
    return activo ? "<span class='label label-success'>Abertas</span>".html_safe : "<span class='label label-important'>Fechadas</span>".html_safe
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


  #retorna qual o input
  def tipo_input(tipo,nome,obrigatoria)
    if tipo == 1
      text_field_tag 'respostas[resposta][]', nil,:required => obrigatoria,:placeholder=> nome
    else
        html = "<input type='checkbox' name='respostas[resposta][]' value='1'>".html_safe 
        html << "<input type='hidden'  name='respostas[resposta][]'  value='0' />".html_safe 
    end
 end

 def e_obrigatoria?(obrigatoria)
  if obrigatoria
    return "**".html_safe
  end
 end




end
