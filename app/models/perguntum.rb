class Perguntum < ActiveRecord::Base
  attr_accessible :activa, :descricao, :tipo, :titulo,:comite_id

  validates :comite_id,:descricao, :tipo, :titulo, :presence => true

  
  #default_scope where(:activa => true)

  has_many :pergunta_forms


  def self.my_find(idP)
  	where(
		  id: idP, 
		  activa: true).first
  end

end
