class AddColumnRecrutamentoIdToCounter < ActiveRecord::Migration
  def change
    add_column :counters, :recrutamento_id, :integer
  end
end
