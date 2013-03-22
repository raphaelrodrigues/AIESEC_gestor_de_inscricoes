class CreatePerguntaForms < ActiveRecord::Migration
  def change
    create_table :pergunta_forms do |t|
      t.integer :pergunta_id
      t.integer :ordem
      t.boolean :obrigatoria
      t.integer :formulario_id

      t.timestamps
    end
  end
end
