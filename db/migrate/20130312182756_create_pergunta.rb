# -*- encoding : utf-8 -*-
class CreatePergunta < ActiveRecord::Migration
  def change
    create_table :pergunta do |t|
      t.string :titulo
      t.string :descricao
      t.integer :tipo
      t.boolean :activa
      t.integer :formulario_id

      t.timestamps
    end
  end
end
