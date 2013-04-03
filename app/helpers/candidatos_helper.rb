module CandidatosHelper

	def estadoToLabel(estado)
		if !estado.nil?
			return "<span class='label label-info'>#{estado.nome}</span>".html_safe
		else
			return "<span class='label label-warning'>Não Contactado</span>".html_safe
		end
	end	

	
	def tipoToStringLabel(tipo)
		tipo == 1 ? "<span class='label label-success'>Membros</span>".html_safe : "<span class='label label-info'>&nbsp;Estagio&nbsp;&nbsp;</span>".html_safe
	end

	def age(dob)
	  #dob = Date.strptime(dob,"%m-%d-%Y")
	  #dob = DateTime.parse(dob)
	  dob = dob.to_time
	  now = Time.now.utc.to_date
	  now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end

	def getUltimoUpdate
		if @estados.blank?
			"Sem alteracoes"
		else
			@estados.first.updated_at.to_formatted_s(:short)
		end
	end

end
