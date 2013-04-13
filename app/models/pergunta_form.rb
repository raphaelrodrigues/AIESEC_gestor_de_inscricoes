# -*- encoding : utf-8 -*-
class PerguntaForm < ActiveRecord::Base
  attr_accessible :formulario_id, :obrigatoria, :ordem, :perguntum_id

  belongs_to :formulario
  validates :formulario_id, :presence => true

  belongs_to :perguntum

  default_scope :order => 'ordem ASC'

  def self.reorder(formulario_id)
  	where("formulario_id = ?",formulario_id).each do |p|
  		p.ordem = p.ordem + 1
  		p.save
  	end
  end
  
end
