class CreateEstadoRecruts < ActiveRecord::Migration
  def change
    create_table :estado_recruts do |t|
      t.integer :tipo
      t.integer :comite_id
      t.string :nome
      t.integer :ordem

      t.timestamps
    end
  end
end
