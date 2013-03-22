class CreateCandidatos < ActiveRecord::Migration
  def change
    create_table :candidatos do |t|
      t.string :nome
      t.string :telemovel
      t.string :data_nascimento
      t.integer :comite_id
      t.integer :tipo
      t.integer :recrutamento_id

      t.timestamps
    end
  end
end
