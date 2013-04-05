# -*- encoding : utf-8 -*-
class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :nome
      t.date :data
      t.text :descricao
      t.string :responsavel

      t.timestamps
    end
  end
end
