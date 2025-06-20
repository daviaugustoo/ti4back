class MetricasController < ApplicationController

  # Relatorio da pagina de relatorio mensal
  def metricas_relatorio_mensal

    maior_residuo_unico = busca_maior_residuo
    start_date = Date.new(params[:ano].to_i, params[:mes].to_i, 1)
    end_date = start_date.end_of_month
    maior_evento = buscar_maior_evento
    maior_residuo = nil
    if !maior_evento.nil?
      maior_residuo = maior_evento.residuos
    end
    metricas = {
    quatia_empresas: Empresa.count,
    quantia_eventos: Evento.where("data_inicio <= ? AND data_fim >= ?", end_date, start_date).count,
    maior_residuo: maior_residuo_unico[0],
    maior_residuo_valor: maior_residuo_unico[1],
    maior_evento: maior_evento,
    residuos_maior_evento: maior_residuo,
    total_residuo_no_mes: busca_total_residuos_no_mes
    }
    render json: metricas
  end

  # Calcula a média de resíduos por tipo no mês atual
    def grafico_media_residuos_total
      residuos = Residuo.all
      if residuos.empty?
      render json: {
        papel: 0.0,
        plastico: 0.0,
        metal: 0.0,
        vidro: 0.0,
        organico: 0.0,
        perigoso: 0.0,
        isopor: 0.0
      }
      return
    end
      media = {
        papel: residuos.average(:papel).to_f,
        plastico: residuos.average(:plastico).to_f,
        metal: residuos.average(:metal).to_f,
        vidro: residuos.average(:vidro).to_f,
        organico: residuos.average(:organico).to_f,
        perigoso: residuos.average(:perigoso).to_f,
        isopor: residuos.average(:isopor).to_f
      }
      render json: media
    end

    def grafico_media_residuos
    residuos = ResiduoQuery.new(params).buscar_por_mes_e_ano
    papel = 0
    plastico = 0
    metal = 0
    vidro = 0
    organico = 0
    perigoso = 0
    isopor = 0

    if residuos.empty?
      render json: {
        papel: 0.0,
        plastico: 0.0,
        metal: 0.0,
        vidro: 0.0,
        organico: 0.0,
        perigoso: 0.0,
        isopor: 0.0
      }
      return  # <- ESSENCIAL para evitar duplo render
    end

    residuos.each do |residuo|
      papel += residuo.papel
      plastico += residuo.plastico
      metal += residuo.metal
      vidro += residuo.vidro
      organico += residuo.organico
      perigoso += residuo.perigoso
      isopor += residuo.isopor
    end

    if residuos.count > 0
      papel /= residuos.count
      plastico /= residuos.count
      metal /= residuos.count
      vidro /= residuos.count
      organico /= residuos.count
      perigoso /= residuos.count
      isopor /= residuos.count
    end

    media = {
      papel: papel.to_f,
      plastico: plastico.to_f,
      metal: metal.to_f,
      vidro: vidro.to_f,
      organico: organico.to_f,
      perigoso: perigoso.to_f,
      isopor: isopor.to_f
    }

    render json: media
  end


  private


    def busca_maior_residuo
      residuos = ResiduoQuery.new(params).buscar_por_mes_e_ano
      if residuos.empty?
        return [nil, 0]
      end
      papel = residuos.maximum(:papel)
      plastico = residuos.maximum(:plastico)
      metal = residuos.maximum(:metal)
      vidro = residuos.maximum(:vidro)
      organico = residuos.maximum(:organico)
      perigoso = residuos.maximum(:perigoso)
      isopor = residuos.maximum(:isopor)
      # Calcula o maior valor entre os resíduos
      maior_valor = [papel, plastico, metal, vidro, organico, perigoso, isopor].max
      # Verifica qual resíduo tem o maior valor
      if maior_valor == papel
        res = "Papel"
      elsif maior_valor == plastico
        res = "Plastico"
      elsif maior_valor == metal
        res = "Metal"
      elsif maior_valor == vidro
        res = "Vidro"
      elsif maior_valor == organico
        res = "Organico"
      elsif maior_valor == perigoso
        res = "Perigoso"
      else
        res = "Isopor"
      end
      return [res, maior_valor]
    end

    def busca_total_residuos_no_mes
      residuos = ResiduoQuery.new(params).buscar_por_mes_e_ano
      total = 0
      if residuos.empty?
        return total
      end
      residuos.each do |residuo|
        total += residuo.papel + residuo.plastico + residuo.metal + residuo.vidro + residuo.organico + residuo.perigoso + residuo.isopor
      end
      total
    end

    def buscar_maior_evento
      residuoBuscado = ResiduoQuery.new(params).buscar_por_mes_e_ano
      if residuoBuscado.empty?
        return nil
      end
      id = 0
      maior = 0
      residuoBuscado.each do |residuo|
        if (residuo.papel + residuo.plastico + residuo.metal + residuo.vidro + residuo.organico + residuo.perigoso + residuo.isopor) > maior.to_i
          maior = (residuo.papel + residuo.plastico + residuo.metal + residuo.vidro + residuo.organico + residuo.perigoso + residuo.isopor)
          id = residuo.evento_id
        end
      end
      if(id > 0)
        evento = Evento.find(id)
      else
        evento = nil
      end
      return evento
    end
  end
