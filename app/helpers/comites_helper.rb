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

	

end
