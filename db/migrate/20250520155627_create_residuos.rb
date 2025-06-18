class CreateResiduos < ActiveRecord::Migration[7.1]
  def change
    create_table :residuos do |t|
      t.float :papel
      t.float :plastico
      t.float :metal
      t.float :vidro
      t.float :organico
      t.float :perigoso
      t.float :isopor
      t.integer :eventoId

      t.timestamps
    end
  end
end
