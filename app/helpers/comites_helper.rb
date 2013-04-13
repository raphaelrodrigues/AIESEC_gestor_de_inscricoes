# -*- encoding : utf-8 -*-
module ComitesHelper


	def current_form?(id,id_com)
		if id == id_com
			return true
		else
			return false
		end
	end

	#verifica se id é igual ao comite logado
	def current_comite?(id_com)
		if id_com == current_comite.id
			return true
		else
			return false
		end
	end

	def getPathFormulario(tipo)
		if tipo == 1
			path = "formulario_membros"
		else
			path = "formulario_estagios"
		end

		return path
	end


	def tipoPerguntaToString(tipo)
		case tipo
			when 1
				"Respota Aberta"
			when 2
				"Escolha Multipla"
			when 3
				"ComboBox"
			when 4
				"Radio Box"
			when 5
				"Area de Texto"
		end
	end

	def arrayToString(opcoes)
		html = "".html_safe
		opcoes.each do |op|
			html << op.html_safe
			html << "<br>".html_safe
		end
		return html
	end

end
