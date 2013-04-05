# -*- encoding : utf-8 -*-
class AddColumnRecrutamentoIdToFormulario < ActiveRecord::Migration
  def change
    add_column :formularios, :recrutamento_id, :integer
  end
end
