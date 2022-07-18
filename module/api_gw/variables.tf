variable "name" {
  type=string
  description="Api gateway name"
}

variable "iam_role" {
  type=string
  description="IAM role name"
}

variable "endpoints" {
  type = set(string)
  default = []
  description = "values of endpoints"
}

variable "methods" {
  type = map(any)
  default = {}
  description = "values of methods"
}

variable "resources" {
  type = map(any)
  default = {}
  description = "values of resources"
}
