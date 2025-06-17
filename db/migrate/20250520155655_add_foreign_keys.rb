class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    rename_column :eventos, :eventoId, :empresa_id
    rename_column :residuos, :eventoId, :evento_id
    add_foreign_key :eventos, :empresas, column: :empresa_Id, primary_key: :id
    add_foreign_key :residuos, :eventos, column: :evento_Id, primary_key: :id
  end
end
