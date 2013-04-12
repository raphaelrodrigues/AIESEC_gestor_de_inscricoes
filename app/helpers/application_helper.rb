# -*- encoding : utf-8 -*-
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
    if activo == true
      "<span class='label label-success'>Abertas</span>".html_safe
    else
      "<span class='label label-important'>Fechadas</span>".html_safe
    end
    #activo ? "<span class='label label-success'>Abertas</span>".html_safe : "<span class='label label-important'>Fechadas</span>".html_safe
  end

  def inscricoes(activo)
      activo ? "<span class='label label-success'>Abertas</span>".html_safe : "<span class='label label-important'>Fechadas</span>".html_safe
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


  def name

  end
   #retorna qual o input
  def tipo_input(tipo,opcoes,obrigatoria,nome,id)
    case tipo
    when 1
     name = "respostas[#{id}][resposta][]"
     return text_field_tag name, nil,:required => obrigatoria,:placeholder=> nome
      
     
    when 4
        html = "<div id='obrigatoria_#{obrigatoria}'>".html_safe
         if !opcoes.empty?
          
          opcoes.each do |o|

            html << "<input type='checkbox' name='respostas[#{id}][resposta][]' value='".html_safe
            html << o.html_safe
            html << "'>&nbsp;&nbsp;".html_safe
            html << o.html_safe
            html << "<br>".html_safe
            #html << "<input type='hidden'  name='respostas[id][resposta][]'  value='0' />".html_safe 
            
          end

          html << "</div>".html_safe
        end
          return html
        
    when 3
      html = ""
      if !opcoes.empty?
        select_tag "respostas[#{id}][resposta][]", options_for_select(opcoes.collect{ |u| [u, u] }), :include_blank => true
      end

    when 2  
      html = "".html_safe
        if opcoes != ""
          opcoes.each do |o|
            html << "<input type='radio' name='respostas[#{id}][resposta][]' value='#{o}'>  #{o}<br>".html_safe 
            #html << "<input type='hidden'  name='respostas[resposta][]'  value='0' />".html_safe 
          end
        end
      return html

    when 5
      name = "respostas[#{id}][resposta][]"
      return text_area_tag name, nil,:required => obrigatoria,:placeholder=> nome
    end

 end

 def my_text_field_tag(name, value = nil, options={})
  text_field_tag name, value
 end

 def e_obrigatoria?(obrigatoria)
  if obrigatoria
    return "**".html_safe
  end
 end


 def obrigatoria?(obr)
  if obr == true
    '<td style="color:green;"><i class=" icon-ok"></i></td>'.html_safe
  else
    '<td style="color:red;"><i class="icon-remove"></i></td>'.html_safe
  end
 end

 #verifica qual a pagina em que está
 # para poder alterar o caminho da pesquisa
 # a pesquisa é feita  nos candidatos membros ou candidatos estagios
 # esta funcao altera a o caminho do form de pesquisa
 def getPathSearch

  if current_page?(candidatos_membros_path)
      candidatos_membros_path
  elsif current_page?(candidatos_fora_epoca_path)
      candidatos_fora_epoca_path
  else
      candidatos_estagios_path
  end

 end

 def isAdmin?
  current_comite.nome == "Aiesec Admin" ? true : false
 end

 



end
