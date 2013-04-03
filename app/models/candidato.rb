class Candidato < ActiveRecord::Base
  attr_accessible :comite_id, :data_nascimento, :nome, :recrutamento_id, :telemovel, :tipo ,:email


  validates_inclusion_of :tipo, :in => [1,2]
  validates_presence_of :comite_id,:nome,:recrutamento_id
  default_scope :order => 'created_at DESC'
  

  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  belongs_to :recrutamento
  has_many :respostas
  has_many :estados

  

  def self.search(search,page)
      paginate :per_page => 10, :page => page,
           :conditions => ['nome LIKE  ?', "%#{search}%"]

      
  end

  #Para que o controller nao fique tao grande
  def self.novo(val,tipo,comite_id,recrutamento_id)
  	new(nome: val[:nome],telemovel: val[:telemovel],data_nascimento: val[:data_nascimento],comite_id: comite_id,tipo: tipo,recrutamento_id: recrutamento_id,email: val[:email])
  end


  def self.to_csv(options = {},candidato,respostas)
    CSV.generate(options) do |csv|
      csv << column_names
        csv << candidato.attributes.values_at(*column_names)
        respostas.each do |r|
          csv << r.attributes.values_at(*column_names)
        end
    end
  end

  def age(dob)
    #dob = Date.strptime(dob,"%m-%d-%Y")
    #dob = DateTime.parse(dob)
    dob = dob.to_time
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end


  def self.percentagem_idades(recrutamento_id)

    candidatos = find(:all, :conditions =>["recrutamento_id = ?",recrutamento_id])
    idades = Array.new

    stats = Array.new


    candidatos.each do |c|
      idade = c.age(c.data_nascimento)
      
      idades.push([idade,1])
    end

    conver_results = Hash.new { |h,k| h[k] = [] }
    idades.each { |k,v| conver_results[k] << v }
    
    conver_results.each do |i|
      n = i[1].count
      stats.push([i[0].to_s,n])
    end
    
    return stats

  end

  
  def self.est_candidatos(recrutamento)
    lista_estados = Array.new
    stats = Array.new

    recrutamento.candidatos.each do |c|
      if c.estados.first.nil?
          estado = "Nao contactado"
      else
          estado = c.estados.first.nome
      end
      
      lista_estados.push([estado.to_s,1])
    end

    conver_results = Hash.new { |h,k| h[k] = [] }
    lista_estados.each { |k,v| conver_results[k] << v }
    
    conver_results.each do |e|
      n = e[1].count
      stats.push([e[0].to_s,n])
    end

    return stats
  end


  def self.candidatos_estado(candidatos,estado)
    n = 0
    candidatos.each do |c|
      estado_cand = c.estados.first
      if !estado_cand.nil?
        if estado == estado_cand.nome
          n += 1
        end
      end
    end

    return n
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
