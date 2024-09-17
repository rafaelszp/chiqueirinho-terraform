
data "local_file" "teste" {
  count = fileexists("out/teste.txt") ? 1 : 0
  filename = "out/teste.txt"
}

resource "local_file" "teste" {
  content =  length(data.local_file.teste)==0 ?  "teste ${random_integer.priority.result}": "${data.local_file.teste[0].content} - ${random_integer.priority.result}"
  filename = "out/teste.txt"
}

resource "random_integer" "priority" {
  min = 1
  max = 50000
  keepers = {
    content = length(data.local_file.teste)
  }
}

resource "local_file" "conditional_file" {
  count = length(data.local_file.teste)>0 ? 1 : 0
  content =  "teste ${random_integer.priority.result}"
  filename = "out/conditional_test.txt"
}