variable "cluster_identifier" {
    type = string
    description = "The name of the cluster"
    default = "my-cluster"
}

variable "engine" {
    type = string
    default = "aurora-postgresql"
}

variable "engine_mode" {
    type = string
    default = "provisioned"
}

variable "engine_version" {
    type = string
    default = "13.6"
}

variable "database_name" {
    type = string
    default = "my-db"
}

variable "master_username" {
    type = string
    default = "postgres"
}

# variable "master_password" {
#     type = string
#     default = "root"
# }

variable "min_capacity" {
    type = number
    default = 0.5
}

variable "max_capacity" {
    type = number
    default = 5
}

variable "storage_encrypted" {
    type = bool
    default = true
}

variable "availability_zones" {
    type = list(string)
    default = [
        "us-east-1a",
        "us-east-1b",
        "us-east-1c"
    ]
}

variable "subnet_group_name" {
    type = string
    default = "my-subnet-group"
}

variable "subnet_ids" {
    type = list(string)
    default = []
}

variable "password_secret_manager" {
    type = string
    default = "my-password-secret-manager"
}

variable "final_snapshot_identifier" {
    type = string
    default = "my-final-snapshot"
}




