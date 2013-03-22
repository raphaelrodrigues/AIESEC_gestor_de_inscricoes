class SessionsController < ApplicationController
  	
	skip_before_filter :authorize, :except => :destroy	#passa o filtro para que seja possivel fazer login
	layout "log_in"  									#altera o layout da pagina
	
  	def new
	end

	#metodo que cria a sessão
	def create
	  comite = Comite.find_by_nome(params[:nome])
	  if comite && Comite.authenticate(params[:nome],params[:password])
	    if params[:remember_me]
	      cookies.permanent[:auth_token] = comite.auth_token
	    else
	      cookies[:auth_token] = comite.auth_token
	    end
	    
	    redirect_to "/comites", :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  cookies.delete(:auth_token)
	  redirect_to "/log_in", :notice => "Logged out!"
	end
end