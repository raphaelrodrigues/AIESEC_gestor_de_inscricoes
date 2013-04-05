# -*- encoding : utf-8 -*-
class CreateFormularios < ActiveRecord::Migration
  def change
    create_table :formularios do |t|
      t.string :nome
      t.integer :comite_id
      t.integer :estado ,:default => 1
      t.integer :tipo

      t.timestamps
    end
  end
end
