class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :pergunta_forms, :pergunta_id, :perguntum_id
  end

  def down
  end
end
