class AddColumnActivoToCandidato < ActiveRecord::Migration
  def change
    add_column :candidatos, :activo, :integer,:default => 1
  end
end
