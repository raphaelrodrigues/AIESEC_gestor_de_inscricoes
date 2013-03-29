class AddColumnEmailToCandidato < ActiveRecord::Migration
  def change
    add_column :candidatos, :email, :string
  end
end
