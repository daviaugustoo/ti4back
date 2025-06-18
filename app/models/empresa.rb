class Empresa < ApplicationRecord
  has_many :eventos, class_name: "Evento", foreign_key: "empresa_id"
end
