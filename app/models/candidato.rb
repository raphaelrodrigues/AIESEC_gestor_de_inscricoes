class Candidato < ActiveRecord::Base
  attr_accessible :comite_id, :data_nascimento, :nome, :recrutamento_id, :telemovel, :tipo

  has_many :respostas
  has_many :estados

  belongs_to :recrutamento

  default_scope :order => 'created_at DESC'

  def self.search(nome,page)
      paginate :per_page => 10, :page => page,
           :conditions => ['nome like ?', "%#{nome}%"]
  end

  #Para que o controller nao fique tao grande
  def self.novo(val,tipo,comite_id,recrutamento_id)
  	new(nome: val[:nome],telemovel: val[:telemovel],data_nascimento: val[:data_nascimento],comite_id: comite_id,tipo: tipo,recrutamento_id: recrutamento_id)
  end

end
