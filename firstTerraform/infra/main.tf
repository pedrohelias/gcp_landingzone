#main do bootstrap pra inicializar todo o projeto

#gera um ID aleatório que gera nomes únicos para criação de recursos - verificar o uso
resource "random_id" "suffix" {
  byte_length = 2
}

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

#define as roles para um membro, ou conjunto de membros em nivel de organização
resource "google_organization_iam_member" "project_creator" {
  for_each = toset(var.group_org_admins) #aqui utiliza-se for each pois ele analisa uma lista de strings, semelhante ao "turnOnAPis"

  org_id = var.org_id
  role   = "roles/resourcemanager.projectCreator"
  member = "group:${each.value}"
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
  member = "serviceAccount:${var.iac_service_account_email}" #verificar se vai criar service account nova ou utializar service account do bucket - VALIDAR. Tem que ser a mesma service account - pode separar as service accounts?
}

#atribuição de permissão para a conta de serviço do Terraform no nivel da organização, para criar recursos
resource "google_organization_iam_binding" "terraform_sa_org_permissions" {
  org_id = var.org_id
  role   = "roles/owner"
  members = [
    "serviceAccount:${var.iac_service_account_email}", #aqui pode alterar a variavel se necessário, caso usuários aptos a nivel de buckets naõ sejam os mesmos com atribução para criação de recursos - Verificar

  ]
}

# Criação de keyrinf para orgainzação
resource "google_kms_key_ring" "terraform_keyring" {
  name     = "terraform-keyring"
  location = var.default_region
  project  = var.project_id
}

# Cria uma chave de criptografia dentro do KeyRing
resource "google_kms_crypto_key" "terraform_key" {
  name            = "terraform-key"
  key_ring        = google_kms_key_ring.terraform_keyring.id
  #rotation_period = "7776000s" #opcional, aqui são 90 dias
  purpose         = "ENCRYPT_DECRYPT"
}

# Identifica a conta de serviço padrão usada pelo GCS no projeto
data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

# Permite que o GCS use a chave para criptografar/descriptografar objetos
resource "google_kms_crypto_key_iam_member" "gcs_kms_user" {
  crypto_key_id = google_kms_crypto_key.terraform_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

# Bucket com criptografia via KMS ativada - vai armazenar o estado remoto do terraform (vai tratar o terraform.tfstate criado após o terraform apply)

resource "google_storage_bucket" "terraform_state" {
  name                        = "${var.project_id}-tfstate-${random_id.suffix.hex}"
  project                     = var.project_id
  location                    = var.default_region
  versioning {
    enabled = true
  }
  uniform_bucket_level_access = true
  force_destroy               = false

  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_key.id
  }
}