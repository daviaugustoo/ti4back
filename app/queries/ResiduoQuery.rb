class ResiduoQuery
  def initialize(params)
    @mes = params[:mes].to_i
    @ano = params[:ano].to_i
    @empresa_id = params[:empresa_id]
  end

  def buscar_por_mes_e_ano
    return Residuo.none unless @mes.between?(1, 12) && @ano > 1900

    start_date = Date.new(@ano, @mes, 1)
    end_date = start_date.end_of_month

    puts "start_date: #{start_date}, end_date: #{end_date}, empresa_id: #{@empresa_id}"
    eventos = Evento.where("data_inicio <= ? AND data_fim >= ?", end_date, start_date)
    residuos = []
    if eventos.empty?
      puts "Nenhum evento encontrado para o período especificadoooooooooo."
      return Residuo.none
    end
    eventos.each do |evento|
      residuos << evento.residuos
    end

    residuos
  end

  def buscar_por_mes_e_ano_por_evento
    return Residuo.none unless @mes.between?(1, 12) && @ano > 1900 && @empresa_id.present?

    start_date = Date.new(@ano, @mes, 1)
    end_date = start_date.end_of_month

    puts "start_date: #{start_date}, end_date: #{end_date}, empresa_id: #{@empresa_id}"

    eventos = Evento.where(empresa_id: @empresa_id).where("data_inicio <= ? AND data_fim >= ?", end_date, start_date)
    residuos = []
    if eventos.empty?
      puts "Nenhum evento encontrado para o período especificado."
      return Residuo.none
    end
    eventos.each do |evento|
      residuos += evento.residuos
    end
    residuos
  end
end
