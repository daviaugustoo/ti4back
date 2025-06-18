class CreateEmpresas < ActiveRecord::Migration[7.1]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :cnpj
      t.string :contato

      t.timestamps
    end
  end
end
