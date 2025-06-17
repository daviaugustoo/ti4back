Rails.application.routes.draw do
  resources :metricas
  resources :residuos
  resources :eventos
  resources :empresas

  get "/buscaEmpresaPorNome/:nome", to: "empresas#busca_por_nome"
  get "/eventosPorEmpresaId/:id", to: "eventos#eventos_por_empresa_id"
  get "/residuosPorEventoId/:evento_id", to: "residuos#residuos_por_evento_id"
  get "/relatorioMensal", to: "metricas#metricas_relatorio_mensal"
  get "/graficoMediaResiduos", to: "metricas#grafico_media_residuos"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check


end
