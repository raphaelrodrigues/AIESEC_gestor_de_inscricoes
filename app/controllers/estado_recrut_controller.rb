# -*- encoding : utf-8 -*-
class EstadoRecrutController < ApplicationController

  before_filter :estado_belongTo_comite?, :only => [ :edit, :destroy]
  def edit
  	@estado_recrut = EstadoRecrut.find(params[:id])
  end


  def create_estado
    comite_id = params[:estado_recrut][:comite_id]
    tipo = params[:estado_recrut][:tipo]
    params[:estado_recrut][:ordem] = get_ultima_ordem_estados(comite_id,tipo)
  	@estado_recrut = EstadoRecrut.new(params[:estado_recrut])

    @estado_recrut.save

    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { head :no_content }
    end
  end


  def update_estado
  	@estado_recrut = EstadoRecrut.find(params[:id])
  	
    respond_to do |format|
      if @estado_recrut.update_attributes(params[:estado_recrut])
        format.html { redirect_to profile_path, notice: 'Comite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @estado_recrut.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @estado_recrut = EstadoRecrut.find(params[:id])
    @estado_recrut.activo = 0
    @estado_recrut.save

    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { head :no_content }
    end
  end

  
end
