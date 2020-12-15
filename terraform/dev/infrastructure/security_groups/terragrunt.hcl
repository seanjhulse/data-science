include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    find_in_parent_folders("resource_groups"),
    find_in_parent_folders("network")
  ]
}

dependency "resource_groups" {
  config_path = find_in_parent_folders("resource_groups")

  mock_outputs = {
    resource_group_name = "mockname"
  }
}

dependency "network" {
  config_path = find_in_parent_folders("network")

  mock_outputs = {
    network_subnet_data_id = "mockid"
  }
}

inputs = {
  resource_group_name    = dependency.resource_groups.outputs.resource_group_name
  network_subnet_data_id = dependency.network.outputs.network_subnet_data_id
}

generate "required_provider" {
  path      = "__required_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      version = "~> 2.34.0"
    }
  }
}
EOF
}

# Temporary until all infrastructure tasks are modules
generate "variables" {
  path      = "__variables.tf"
  if_exists = "overwrite_terragrunt"
  #contents  = file("tg_environment_variables.hcl")
  contents = <<EOF
variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "OOB"
}
variable "location" {
  description = "Azure Location"
  type        = string
  default     = "eastus"
}
variable "default_tags" {
  description = "Default tags"
  type        = map(any)
  default = {
    IaC = "True"
  }
}
variable "cluster_name" {
  type        = string
  description = "Name to use for the data science culster being created"
  default     = "default"
}
variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rgdefault"
}
variable "network_subnet_data_id" {
  description = "Data Network Subnet Id"
  type        = string
  default     = "networkid"
}
variable "mqtt_topics" {
  type        = list(string)
  description = "The list of MQTT Topics to that should be pulled from the MQTT Broker and pushed into Azure Event Hubs"
  default     = ["default1", "default2"]
}
variable "mqtt_users" {
  type        = list(string)
  description = "The list of users that should be allowed connection to the MQTT Broker"
  default     = ["default1", "default2"]
}
EOF
}
