class AddColumnsEvento < ActiveRecord::Migration[7.1]
  def change
    add_column :eventos, :organizador, :string
    add_column :eventos, :quantia_de_pessoas, :integer
    rename_column :eventos, :data, :data_inicio
    add_column :eventos, :data_fim, :date
    add_column :eventos, :observacoes, :text
    add_column :eventos , :responsavel_pelo_cadastro, :string
  end
end
