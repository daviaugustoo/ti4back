class ResiduosController < ApplicationController

  # GET /residuos
  def index
    @residuos = Residuo.all
    render json: @residuos
  end

  def residuos_por_evento_id
    residuo = Residuo.find_by(evento_id: params[:evento_id])
    if residuo.present?
      render json: residuo
    else
      render json: {error: "Residuo não encontrado para o evento com ID #{params[:evento_id]}"}, status: :not_found
    end
  end

  # PATCH/PUT /residuos/1
  def update
    puts "Parâmetros recebidos: #{params.to_unsafe_h}"
    residuo = Residuo.find_by(evento_id: params[:id])
    if residuo.update(residuo_params)
      render json: residuo
    else
      render json: residuo.errors, status: :unprocessable_entity
    end
  end

  private
    def residuo_params
      params.permit(:papel, :plastico, :metal, :vidro, :organico, :perigoso, :isopor, :evento_id, :id)
    end
end
