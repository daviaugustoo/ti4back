class Residuo < ApplicationRecord
  belongs_to :evento, class_name: "Evento", foreign_key: "evento_id"
end
