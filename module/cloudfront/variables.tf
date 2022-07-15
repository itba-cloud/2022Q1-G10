variable "bucket_name" {
  type = string
  description = "cloudfront frontend bucket name"
}

variable "logging_bucket_name" {
  type = string
  description = "cloudfront logging bucket name"
}

variable "api_gw_url" {
  type = string
  description = "api gateway url"
}

variable "origin_id" {
    type = string
    description = "cloudfront origin id"
}