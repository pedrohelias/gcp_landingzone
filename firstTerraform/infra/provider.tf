# aqui vou descrever a cloud que vou utilizar, no caso é gcp

provider "google" {
    credentials = file(var.gcp_svc_key)
    project = var.gcp_project
    region = var.gcp_region

}

