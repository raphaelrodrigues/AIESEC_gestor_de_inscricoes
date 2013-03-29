class Recrutamento < ActiveRecord::Base
  attr_accessible :comite_id, :estado, :finished_at, :tipo

  
  has_one :formulario
  belongs_to :comite
  has_many :candidatos
  
  validates_inclusion_of :tipo, :in => [1,2]

  default_scope order('created_at DESC')

  def self.recrutamento_activo(tipo)
  	where('estado = true and tipo = ?',tipo)[0]
  end

  def inscricao_activa_recrut?
    if self.inscricao_activa == true
      return "Aberta"
    else
      return "Fechada"
    end
  end

  def abre_inscricao
  	self.inscricao_activa = 1
    self.save
  end

  def fecha_inscricao
    #self.estado = 0
  	self.inscricao_activa = 0
    self.finished_at = Time.now
  	self.save
  end


  

  
end
