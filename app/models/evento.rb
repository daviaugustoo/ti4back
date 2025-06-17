class Evento < ApplicationRecord
  belongs_to :empresa
  has_one :residuos, class_name: "Residuo", foreign_key: "evento_id", dependent: :destroy
end
