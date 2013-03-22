class AddColumnCandidatoIdToEstado < ActiveRecord::Migration
  def change
    add_column :estados, :candidato_id, :integer
  end
end
