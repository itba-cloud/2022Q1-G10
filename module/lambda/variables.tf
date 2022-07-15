
variable "iam_role" {
  type    = string
  description = "lambda iam role name" 
}

variable "security_group_ids" {
  type    = list(string)
  default = []
  description = "security group ids"
}

variable "name" {
  type = string
  description = "lambda function name"
}

variable "zip" {
  type = string
  description = "lambda code zip"
}

variable "handler" {
  type = string
  description = "lambda handler"
}

variable "runtime" {
  type = string
  description = "lambda runtime"
}

variable "subnet_ids" {
  type    = list(string)
  default = []
  description = "lambda subnet ids"
}




