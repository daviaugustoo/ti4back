class AddColumnsEmpresas < ActiveRecord::Migration[7.1]
  def change
    add_column :empresas, :sala, :string
    add_column :empresas, :telefone, :string
    rename_column :empresas, :contato, :email
    add_column :empresas, :responsavel_pelo_cadastro, :string
  end
end
