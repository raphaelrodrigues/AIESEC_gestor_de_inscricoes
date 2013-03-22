class Perguntum < ActiveRecord::Base
  attr_accessible :activa, :descricao, :tipo, :titulo,:comite_id

  validates :comite_id,:descricao, :tipo, :titulo, :presence => true

  
  #default_scope where(:activa => true)

  has_many :pergunta_forms


  def self.activa
		where("activa = true")
  end

end
