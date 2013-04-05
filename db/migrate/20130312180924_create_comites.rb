# -*- encoding : utf-8 -*-
class CreateComites < ActiveRecord::Migration
  def change
    create_table :comites do |t|
      t.string :nome
      t.string :password_hash
      t.string :password_salt
      t.string :descricao
      t.string :email
      t.string :telefone
      t.string :morada
      t.string :email_ocp
      t.string :auth_token

      t.timestamps
    end
  end
end
