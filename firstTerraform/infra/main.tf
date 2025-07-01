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

#criar um bucket para armazenar o estado remoto do terraform (vai tratar o terraform.tfstate criado após o terraform apply)
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

#define as roles para um membro, ou conjunto de membros em nivel de organização
resource "google_organization_iam_binding" "project_creator_binding" {
  org_id = var.org_id
  role   = "roles/resourcemanager.projectCreator"
  members = [
    "group:${var.group_org_admins}", #caso tenha um grupo
  ]
}

#define as roles para um membro, ou conjunto de membros em nível de organização, mas dessa vez relacionado ao billing
resource "google_organization_iam_binding" "billing_creator_binding" {
  org_id = var.org_id
  role   = "roles/billing.creator"
  members = [
    "group:${var.group_billing_admins}",
  ]
}

#atribuiçaõ de permissão do IAM em nível de bucket para membro específico da organização
resource "google_storage_bucket_iam_member" "terraform_sa_bucket_admin" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.iac_service_account_email}"
}

#atribuição de permissão para a conta de serviço do Terraform no nivel da organização, para criar recursos
resource "google_organization_iam_binding" "terraform_sa_org_permissions" {
  org_id = var.org_id
  role   = "roles/owner"
  members = [
    "serviceAccount:${var.iac_service_account_email}", #aqui pode alterar a variavel se necessário, caso usuários aptos a nivel de buckets naõ sejam os mesmos com atribução para criação de recursos 

  ]
}