class AddColumnTipoToCounter < ActiveRecord::Migration
  def change
    add_column :counters, :tipo, :integer
  end
end
