//TODO change default values
variable "bucket_name" {
    type = string
    default = "www-bucket"
}

variable "logging_bucket_name" {
    type = string
    default = "logging-bucket"
}

variable "api_gw_url" {
    type = string
    default = "api-gw-url"
}