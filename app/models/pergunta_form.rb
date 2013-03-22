class PerguntaForm < ActiveRecord::Base
  attr_accessible :formulario_id, :obrigatoria, :ordem, :perguntum_id

  belongs_to :formulario
  validates :formulario_id, :presence => true

  belongs_to :perguntum

  default_scope :order => 'ordem ASC'


  
end
