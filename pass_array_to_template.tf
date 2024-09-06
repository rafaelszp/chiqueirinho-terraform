
locals {
  joined_int_list = [for i in var.my_int_list : "\"${tostring(i)}\""]
}

data "template_file" "json_file" {
  template = file("${path.module}/templates/template.json")
  vars = {
    int_array = "[${join(", ", local.joined_int_list)}]"
  }
}

variable "my_int_list" {
  type = list(number)
  default = [1, 2, 33]  
}

output "json_file" {
  value = data.template_file.json_file.rendered  
}