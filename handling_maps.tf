#REFERENCE: https://discuss.hashicorp.com/t/howto-filter-element-of-map/4434/3
locals {
  interfaces = {
    nic1 = {
      name = "main"
      ip = "xyz"
      primary = true
    },
    nic2 = {
      name = "admin"
      ip = "zyx"
      primary = false
    }
  }
}

output "filter_object" {
  value = { for k, v in local.interfaces :  k => v if v.primary == true }
}

output "filter_array" {
  value = [ for k, v in local.interfaces :  k if v.primary == true ][0]
}