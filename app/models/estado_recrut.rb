# -*- encoding : utf-8 -*-
class EstadoRecrut < ActiveRecord::Base
  attr_accessible :comite_id, :nome, :ordem, :tipo

  validates_inclusion_of :tipo, :in => [1,2]

  validates_presence_of :comite_id,:nome,:ordem,:tipo

  default_scope :order => 'ordem ASC'
  
  belongs_to :comite



  def self.activos(tipo,comite_id)
  	find(:all,:conditions =>["comite_id = ? and tipo = ? and activo = 1",comite_id,tipo])
  end

  def self.my_last(comite_id,tipo)
  	find(:all,:conditions =>["comite_id = ? and tipo = ? and activo = 1",comite_id,tipo]).last
  end
end
