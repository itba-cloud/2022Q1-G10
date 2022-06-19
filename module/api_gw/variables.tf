variable "name" {
  type=string
  default="api-gateway"
}

variable "endpoints" {
  type = set(string)
  default = []
}

variable "methods" {
  type = map(any)
  default = {}
}