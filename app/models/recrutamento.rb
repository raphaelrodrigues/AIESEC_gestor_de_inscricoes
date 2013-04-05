# -*- encoding : utf-8 -*-
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

  def self.inscricao_aberta?
    where('inscricao_activa = true')
  end

  def self.activo_and_aberto(tipo)
    where('estado = true and tipo = ? and inscricao_activa = true',tipo)[0]
  end

  def inscricao_activa_recrut?
    if self.inscricao_activa == true
      return true
    else
      return false
    end
  end

  def abre_inscricao
  	self.inscricao_activa = true
    self.save
  end

  def fecha_inscricao
    #self.estado = 0
  	self.inscricao_activa = false
    self.finished_at = Time.now
  	self.save
  end

  #devolve percentagem de views e de inscricoes
  def viewEinscricoes(counter)
    stats = Array.new

    n_cand = self.candidatos.count.to_f
    n_views = counter.visitas.to_f
    total = n_cand + n_views
    
    n_cand != 0 ? (inscritos  = n_cand / total * 100) : n_cand = 0
    n_views != 0 ? (visitantes = n_views / total * 100) : n_views = 0
    
    stats.push(["inscritos",inscritos],["Visitas",visitantes])

    return stats
    
  end


  

  
end
