module PerguntaFormsHelper

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


	def num_form_presente(perguntaGeral)
		return perguntaGeral.pergunta_forms.count
	end
end
