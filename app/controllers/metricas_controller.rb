class MetricasController < ApplicationController

  # Relatorio da pagina de relatorio mensal
  def metricas_relatorio_mensal
    maior_residuo = busca_maior_residuo
    puts "Maior resíduo encontrado: #{maior_residuo}"
    metricas = {
    quatia_empresas: Empresa.count,
    quantia_eventos: Evento.count,
    maior_residuo: maior_residuo[0],
    maior_residuo_valor: maior_residuo[1],
    maior_evento: busca_maior_evento,
    total_residuo_no_mes: Residuo.sum("papel + plastico + metal + vidro + organico + perigoso + isopor"),
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

    def busca_maior_residuo
      residuos = Residuo.all
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

    def busca_maior_evento
      residuoBuscado = Residuo.all
      id = 0
      maior = 0
      residuoBuscado.each do |residuo|
        if (residuo.papel + residuo.plastico + residuo.metal + residuo.vidro + residuo.organico + residuo.perigoso + residuo.isopor) > maior.to_i
          maior = (residuo.papel + residuo.plastico + residuo.metal + residuo.vidro + residuo.organico + residuo.perigoso + residuo.isopor)
          id = residuo.evento_id
          puts "Novo maior resíduo encontrado: #{maior} no evento com ID: #{id}"
        end
      end
      if(id > 0)
        evento = Evento.find(id).nome
        puts "Evento com maior resíduo: #{evento}"
      else
        evento = ""
      end
      return evento
    end
end
