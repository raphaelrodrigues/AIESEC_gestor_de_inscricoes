# -*- encoding : utf-8 -*-
class Resposta < ActiveRecord::Base
  attr_accessible :candidato_id, :pergunta_id, :resposta, :tipo

  belongs_to :candidato
end
