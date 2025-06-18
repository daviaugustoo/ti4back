class MudarColunaSenha < ActiveRecord::Migration[7.1]
  def change
    rename_column :usuarios, :senha, :password
  end
end
