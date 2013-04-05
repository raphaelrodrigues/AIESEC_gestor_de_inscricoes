# -*- encoding : utf-8 -*-
class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.integer :comite_id
      t.integer :visitas

      t.timestamps
    end
  end
end
