# -*- encoding : utf-8 -*-
class AddColumnComiteIdFromPergunta < ActiveRecord::Migration
  def change
    add_column :pergunta, :comite_id, :integer
  end
end
