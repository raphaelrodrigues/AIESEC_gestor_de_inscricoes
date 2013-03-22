module CandidatosHelper

	def estadoToLabel(estado)
		if !estado.nil?
			return "<span class='label label-success'>#{estado.nome}</span>".html_safe
		else
			return "<span class='label label-warning'>Nao Contactado</span>".html_safe
		end
	end	
end
