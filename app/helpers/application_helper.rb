module ApplicationHelper

  include LazyHighCharts::LayoutHelper
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
    case tipo
    when 1
      text_field_tag 'respostas[resposta][]', nil,:required => obrigatoria,:placeholder=> nome
    when 4
        html = "<input type='checkbox' name='respostas[resposta][]' value='1'>".html_safe 
        html << "<input type='hidden'  name='respostas[resposta][]'  value='0' />".html_safe 
    when 3
        html = "<input type='comboxbox' name='respostas[resposta][]' value='1'>".html_safe 
        html << "<input type='hidden'  name='respostas[resposta][]'  value='0' />".html_safe 
    when 2
        html = "<input type='radiobox' name='respostas[resposta][]' value='1'>".html_safe 
        html << "<input type='hidden'  name='respostas[resposta][]'  value='0' />".html_safe 
    end
 end

 def e_obrigatoria?(obrigatoria)
  if obrigatoria
    return "**".html_safe
  end
 end


 def obrigatoria?(obr)
  if obr == true
    '<i class=" icon-ok"></i>'.html_safe
  else
    '<i class="icon-remove"></i>'.html_safe
  end
 end

 #verifica qual a pagina em que está
 # para poder alterar o caminho da pesquisa
 # a pesquisa é feita  nos candidatos membros ou candidatos estagios
 # esta funcao altera a o caminho do form de pesquisa
 def getPathSearch

  if current_page?(candidatos_membros_path)
      candidatos_membros_path
  else
      candidatos_estagios_path
  end

 end

 def isAdmin?
  current_comite.nome == "Aiesec Admin" ? true : false
 end

 



end
