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

variable "org_id" {
description = "ID da organização GCP"
type        = string
}

variable "group_org_admins" {
  description = "Email do grupo de admins da organização"
  type        = string
}

variable "group_billing_admins" {
  description = "Email do grupo de billing admins"
  type        = string
}

variable "iac_service_account_email" {
  description = "Email da conta de serviço do Terraform"
  type        = string
}