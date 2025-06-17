class EventosController < ApplicationController
  before_action :set_evento, only: %i[ show update destroy ]

  def eventos_por_empresa_id
    eventos = Evento.where(empresa_id: params[:id])
    render json: eventos
  end

  # GET /eventos
  def index
    @eventos = Evento.all

    render json: @eventos
  end

  # GET /eventos/1
  def show
    render json: @evento
  end

  # POST /eventos
  def create
    puts "Parâmetros recebidos: #{params.to_unsafe_h}"
    evento = Evento.new(evento_params)
    if evento.save
      residuo = Residuo.new(
      papel: 0, plastico: 0, metal: 0, vidro: 0,
      organico: 0, perigoso: 0, isopor: 0,
      evento_id: evento.id
    )
      if residuo.save
        render json: evento, status: :created, location: evento
      else
        render json: residuo.errors, status: :unprocessable_entity
      end
    else
      render json: evento.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /eventos/1
  def update
    if @evento.update(evento_params)
      render json: @evento
    else
      render json: @evento.errors, status: :unprocessable_entity
    end
  end

  # DELETE /eventos/1
  def destroy
    @evento.destroy!
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Evento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def evento_params
      params.permit(:nome,:data_inicio, :data_fim, :empresa_id, :id, :organizador, :quantia_de_pessoas, :observacoes, :responsavel_pelo_cadastro)
    end
end
