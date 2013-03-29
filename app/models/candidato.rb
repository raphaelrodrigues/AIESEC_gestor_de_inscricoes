class Candidato < ActiveRecord::Base
  attr_accessible :comite_id, :data_nascimento, :nome, :recrutamento_id, :telemovel, :tipo, :email

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
  	new(nome: val[:nome],telemovel: val[:telemovel],data_nascimento: val[:data_nascimento],comite_id: comite_id,tipo: tipo,recrutamento_id: recrutamento_id,email: val[:email])
  end
  

  #nao esta a funcionar
  # def self.est_candidatos(recrutamento)
  #   lista_estados = Array.new
  #   num_estados_cand = Array.new
  #   #num_cand = recrutamento_id.candidatos.count

  #   #armazena diferentes estados
  #   recrutamento.candidatos.each do |c|
  #       if c.estados.first.nil?
  #         estado = "Nao contactado"
  #       else
  #         estado = c.estados.first.nome
  #       end
  #       lista_estados.push(estado)
  #   end
  #   #remove estados duplicados
  #   lista_estados.uniq!


  #     recrutamento.candidatos.each do |c|
  #         if c.estados.first.nil?
  #           estado = "Nao contactado"
  #         else
  #           estado = c.estados.first.nome
  #         end

  #         if num_estados_cand.include? estado
  #             num_estados_cand
  #             else
  #               num_estados_cand.push([estado,0])
  #             end
  #             break
  #           end
  #         end
  #       end

  #   return num_estados_cand

  # end

  

end
