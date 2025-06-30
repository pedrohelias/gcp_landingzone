#main do bootstrap pra inicializar todo o projeto


#habilitar as apis do gcp para uso no projeto
resource "google_project_service" "turnOnApis" {
  for_each = toset(var.activate_apis)
  project  = var.project_id
  service  = each.value

  timeouts {
    create = "10m"
    update = "10m" 
  }

  disable_dependent_services = true #em possivel remoção, isso vai unir as apis dependentes e excluí-las
}

resource "google_storage_bucket" "terraform_state" {
  name                        = "${var.project_id}-tfstate-${random_id.suffix.hex}"
  project                     = var.project_id
  location                    = var.default_region
  versioning { 
    enabled = true #se true, permite o versionamento que vai guardar o histórico do terraform
  }
  uniform_bucket_level_access = true #simplifica o acesso 

#   lifecycle_rule {
#     condition {
#      # condições para lifecycle, por exemplo: age = 30
#     }
#     action {
#      #açaõ no condicionamento type = "Delete"
#     }
#   }

  force_destroy = false
}