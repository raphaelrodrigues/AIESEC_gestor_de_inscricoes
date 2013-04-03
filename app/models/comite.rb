class Comite < ActiveRecord::Base
  attr_accessible :descricao, :email, :email_ocp, :morada, :nome, :telefone,:password, :password_confirmation

  
  attr_accessor :password
  
  
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates_format_of :email_ocp, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :nome
  validates_uniqueness_of :nome

  before_save :encrypt_password

  has_many :formularios
  has_many :recrutamento


  def self.authenticate(nome, password)
    comite = find_by_nome(nome)
    if comite && comite.password_hash == BCrypt::Engine.hash_secret(password, comite.password_salt)
      comite
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  #funcao que verifica se tem inscriçoes activas
  def inscricao_activa?(tipo)
    r = self.recrutamento.recrutamento_activo(tipo)

    if !r.nil?
      return r.inscricao_activa_recrut?
    else
      return false
    end
  end

  #cria um novo formulario
  def cria_formulario(tipo,comite_id,recrutamento_id)
    if tipo == 1
          nome = "Formulario Membros"
    else
          nome = "Formulario Estagios"
    end
    
    self.formularios.build(:nome=>nome,:comite_id=> comite_id,:tipo=>tipo,:recrutamento_id=>recrutamento_id)
  end 


  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Comite.exists?(column => self[column])
  end

  def cenas
        obj1 = Array.new
        num_anuncios = Comite.all.count
        Comite.all.each do |c|
          val = (100 / 40) * 100

          obj1.push([ c.nome, val ])
        end

        return obj1
  end


  def candidatos_por_recrutamento(idC,tipo)
    obj = Array.new

    Recrutamento.where(:comite_id => idC,:tipo =>tipo).each do |r|
      num_cand = r.candidatos.count
      obj.push([ r.created_at.strftime('%d/%m/%Y'), num_cand ])
    end

    return obj
  end


end