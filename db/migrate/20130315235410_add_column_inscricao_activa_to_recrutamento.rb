class AddColumnInscricaoActivaToRecrutamento < ActiveRecord::Migration
  def change
    add_column :recrutamentos, :inscricao_activa, :boolean,:default => false
  end
end
