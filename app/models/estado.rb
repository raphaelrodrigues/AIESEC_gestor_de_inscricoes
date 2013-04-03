class Estado < ActiveRecord::Base
  attr_accessible :data, :descricao, :nome, :responsavel,:candidato_id

  validates_presence_of :nome,:candidato_id
  default_scope :order => 'created_at DESC'

  belongs_to :candidato
end
