data "terraform_remote_state" "infrastructure" {
  backend = "azurerm"

  config = {
    key                  = "${var.environment}/${var.infrastructure_remotestate_key}"
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.remotestate_storage_account_name
    container_name       = var.state_container
    client_id            = var.remotestate_client_id
    client_secret        = var.remotestate_client_secret
    subscription_id      = var.remotestate_subscription_id
    tenant_id            = var.remotestate_tenant_id
  }
}


data "terraform_remote_state" "application" {
  backend = "azurerm"

  config = {
    key                  = "${var.environment}/${var.application_remotestate_key}"
    resource_group_name  = var.tfstate_resource_group_name
    storage_account_name = var.remotestate_storage_account_name
    container_name       = var.state_container
    client_id            = var.remotestate_client_id
    client_secret        = var.remotestate_client_secret
    subscription_id      = var.remotestate_subscription_id
    tenant_id            = var.remotestate_tenant_id
  }
}
