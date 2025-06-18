Rails.application.routes.draw do
  resources :metricas
  resources :residuos
  resources :eventos
  resources :empresas
  resources :usuarios

  get "/buscaEmpresaPorNome/:nome", to: "empresas#busca_por_nome"
  get "/eventosPorEmpresaId/:id", to: "eventos#eventos_por_empresa_id"
  get "/residuosPorEventoId/:evento_id", to: "residuos#residuos_por_evento_id"
  get "/relatorioMensal", to: "metricas#metricas_relatorio_mensal"
  get "/graficoMediaResiduos", to: "metricas#grafico_media_residuos"
  get "/graficoMediaResiduosTotal", to: "metricas#grafico_media_residuos_total"
  get "/eventosPorDataEIdEmpresa/:empresa_id", to: "eventos#eventos_por_data_id_empresa"
  get "/eventosPorData", to: "eventos#eventos_por_data"
  post '/login', to: 'autenticacao#login'
  get '/profile', to: 'autenticacao#profile'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check


end
