# -*- encoding : utf-8 -*-
class Counter < ActiveRecord::Base
  attr_accessible :recrutamento_id,:visitas

  validates_presence_of :recrutamento_id
  #funcao para contar as page views
  #incrementa o contador de visitas do comite
  def self.conta(recrutamento_id)
  	counter = find(:all,:conditions =>["recrutamento_id = ? ",recrutamento_id]).first
  	#where("comite_id = ? and tipo = ?",idC,tipo).first

  	counter.visitas = counter.visitas + 1

  	counter.save
  end

  def reset
    self.visitas = 0
    self.save
  end


  def self.my_find(recrutamento_id)
  	find_by_recrutamento_id(recrutamento_id)
  end
end
