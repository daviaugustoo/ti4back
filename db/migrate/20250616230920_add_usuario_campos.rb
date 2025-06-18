class AddUsuarioCampos < ActiveRecord::Migration[7.1]
  def change
    add_column :usuarios, :nome, :string
    add_column :usuarios, :telefone, :string

  end
end
