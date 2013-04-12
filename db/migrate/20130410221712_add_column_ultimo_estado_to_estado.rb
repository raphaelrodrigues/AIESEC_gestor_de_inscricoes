class AddColumnUltimoEstadoToEstado < ActiveRecord::Migration
  def change
    add_column :estados, :ultimo, :integer,:default => 0
  end
end
