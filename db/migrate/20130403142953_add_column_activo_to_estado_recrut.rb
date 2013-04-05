# -*- encoding : utf-8 -*-
class AddColumnActivoToEstadoRecrut < ActiveRecord::Migration
  def change
    add_column :estado_recruts, :activo, :integer,:default => 1
  end
end
