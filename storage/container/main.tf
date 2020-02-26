terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = ">= 1.33.0"
  }
}

locals {
  default_event_rule = {
    event_delivery_schema = null
    topic_name            = null
    labels                = null
    filters               = null
    eventhub_id           = null
  }

  merged_events = [for event in var.events : merge(local.default_event_rule, event)]
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "storage_account" {
  backend = "local"

  config = {
      path = "${var.rspath_storage_account}/terraform.tfstate"
  }
}

resource "azurerm_storage_container" "storage" {
  name                  = var.name
  storage_account_name  = data.terraform_remote_state.storage_account.outputs.name
  container_access_type = var.access_type
}

resource "azurerm_eventgrid_event_subscription" "storage" {
  count = length(local.merged_events)

  name  = local.merged_events[count.index].name
  scope = data.terraform_remote_state.storage_account.outputs.id

  event_delivery_schema = local.merged_events[count.index].event_delivery_schema
  topic_name            = local.merged_events[count.index].topic_name
  labels                = local.merged_events[count.index].labels

  dynamic "eventhub_endpoint" {
    for_each = local.merged_events[count.index].eventhub_id == null ? [] : [true]
    content {
      eventhub_id = local.merged_events[count.index].eventhub_id
    }
  }

  dynamic "subject_filter" {
    for_each = local.merged_events[count.index].filters == null ? [] : [true]
    content {
      subject_begins_with = lookup(local.merged_events[count.index].filters, "subject_begins_with", null) == null ? null : var.events[count.index].filters.subject_begins_with
      subject_ends_with   = lookup(local.merged_events[count.index].filters, "subject_ends_with", null) == null ? null : var.events[count.index].filters.subject_ends_with
    }
  }
}
