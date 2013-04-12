class AddColumnOpcoesToPerguntum < ActiveRecord::Migration
  def change
    add_column :pergunta, :opcoes, :string
  end
end
