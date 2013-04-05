# -*- encoding : utf-8 -*-
class RemoveFormularioIdFromPergunta < ActiveRecord::Migration
  def up
    remove_column :pergunta, :formulario_id
  end

  def down
    add_column :pergunta, :formulario_id, :integer
  end
end
