  #apis a serem carregadas quando o terraform iniciar, e servir de variavel 
  variable "activate_apis" {
    type    = list(string)
  }

  variable "project_id" {
    description = "ID do projeto GCP onde os recursos serão criados"
    type        = string
  }

  variable "default_region" {
  description = "Região padrão para recursos"
  type        = string
}