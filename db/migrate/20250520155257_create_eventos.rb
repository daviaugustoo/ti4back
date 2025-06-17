class CreateEventos < ActiveRecord::Migration[7.1]
  def change
    create_table :eventos do |t|
      t.string :nome
      t.date :data
      t.integer :eventoId

      t.timestamps
    end
  end
end
