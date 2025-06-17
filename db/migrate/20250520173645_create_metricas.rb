class CreateMetricas < ActiveRecord::Migration[7.1]
  def change
    create_table :metricas do |t|

      t.timestamps
    end
  end
end
