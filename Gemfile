source "https://rubygems.org"

ruby "3.4.4"

gem "rails", "~> 7.1.5", ">= 7.1.5.1"
gem "puma", ">= 5.0"
gem "rack-cors", "~> 1.1", ">= 1.1.1"
gem "bcrypt"
gem "jwt"
gem "debug", ">= 1.0.0"
gem "bootsnap", require: false

# Banco de dados
gem "pg", group: :production
gem "sqlite3", group: [:development, :test]

# Necessário para Windows (evita erros com timezones)
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

group :development do
  # gem "spring" # descomente se quiser usar spring
end
