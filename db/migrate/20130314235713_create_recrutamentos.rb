# -*- encoding : utf-8 -*-
class CreateRecrutamentos < ActiveRecord::Migration
  def change
    create_table :recrutamentos do |t|
      t.boolean :estado
      t.integer :tipo
      t.integer :comite_id
      t.date :finished_at

      t.timestamps
    end
  end
end
