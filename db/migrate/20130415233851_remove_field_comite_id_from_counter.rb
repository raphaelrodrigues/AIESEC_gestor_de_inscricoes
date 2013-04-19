class RemoveFieldComiteIdFromCounter < ActiveRecord::Migration
  def up
    remove_column :counters, :comite_id
    remove_column :counters, :tipo
  end

  def down
    add_column :counters, :tipo, :integer
    add_column :counters, :comite_id, :integer
  end
end
