# -*- encoding : utf-8 -*-
class Formulario < ActiveRecord::Base
  attr_accessible :comite_id, :estado, :nome, :tipo,:recrutamento_id

  validates :comite_id, :presence => true
  belongs_to :comite
  belongs_to :recrutamento

  validates_inclusion_of :tipo, :in => [1,2]
  
  has_many :pergunta_forms

  def self.formulario_activo(tipo)
  	where('estado = 1 and tipo = ?',tipo)[0]
  end
end
