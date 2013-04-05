# -*- encoding : utf-8 -*-
class Counter < ActiveRecord::Base
  attr_accessible :comite_id, :visitas,:tipo

  validates_presence_of :comite_id,:tipo
  #funcao para contar as page views
  #incrementa o contador de visitas do comite
  def self.conta(idC,tipo)
  	counter = find(:all,:conditions =>["comite_id = ? and tipo = ?",idC,tipo]).first
  	#where("comite_id = ? and tipo = ?",idC,tipo).first

  	if counter.nil?
  		counter = Counter.new(comite_id: idC, visitas: 1,tipo: tipo)
  	else
  		counter.visitas = counter.visitas + 1
  	end

  	counter.save
  end

  def reset
    self.visitas = 0
    self.save
  end


  def self.my_find(idC,tipo)
  	find(:all,:conditions =>["comite_id = ? and tipo = ?",idC,tipo]).first
  end
end
