# -*- encoding : utf-8 -*-
class SendMail < ActionMailer::Base
  default from: "from@example.com"

  def mail_candidato(candidato,params,n)
  		mail = ["raphaeljr28@gmail.com","raphael.rodrigues@aiesec.net","pg22786@alunos.uminho.pt"]
  		val = params
	  	cand = Candidato.find_by_id(candidato)
		mail(:to => mail[n],
			 :subject => val[:subject],
			 :body => val[:body]
		)
   end
   
end
