# -*- encoding : utf-8 -*-
class CreateResposta < ActiveRecord::Migration
  def change
    create_table :resposta do |t|
      t.integer :candidato_id
      t.integer :pergunta_id
      t.text :resposta
      t.integer :tipo

      t.timestamps
    end
  end
end
