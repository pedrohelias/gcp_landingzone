project_id = "id_project_PPN"

activate_apis = [
  #gerenciamento, iam, roles...
  "iam.googleapis.com",
  "iamcredentials.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "cloudbilling.googleapis.com",
  "serviceusage.googleapis.com",
  "admin.googleapis.com",
  "orgpolicy.googleapis.com",

  #network
  "compute.googleapis.com",
  "container.googleapis.com",
  "networkmanagement.googleapis.com",
  "servicenetworking.googleapis.com",
  "sqladmin.googleapis.com",

  #armazenamento
  "storage-api.googleapis.com",
  "artifactregistry.googleapis.com",

  #monitoramento
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "billingbudgets.googleapis.com",

  #mensageria
  "bigquery.googleapis.com",
  "pubsub.googleapis.com",
  
  #opcionais
  "cloudfunctions.googleapis.com",    #Cloud Functions
  "run.googleapis.com",               #Cloud Run
  "dns.googleapis.com"                #Cloud DNS
]

default_region = "us-central1"

org_id = "org_id"

group_org_admins = [
  "pedro.helias@ppntecnologia.com",
  "matheus.oliveira@ppntecnologia.com.br "
]

group_billing_admins = "pedro.helias@ppntecnologia.com"


iac_service_account_email = "pedro.helias@ppntecnologia.com"

gcp_svc_key = "colocar caminho para o keyfile.json"