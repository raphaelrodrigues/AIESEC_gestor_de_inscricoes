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

end
