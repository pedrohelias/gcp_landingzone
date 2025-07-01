# aqui vou descrever a cloud que vou utilizar, no caso é gcp

provider "google" {
  credentials = file(var.gcp_svc_key)   # arquivo JSON da service account com permissões
  project     = var.project_id          # id do projeto GCP (mesma variável que você já tem)
  region      = var.default_region     # região padrão (pode usar var.default_region ou criar var.gcp_region)
}
