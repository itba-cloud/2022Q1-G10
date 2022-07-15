variable "cluster_identifier" {
    type = string
    description = "The name of the cluster"
}

variable "engine" {
    type = string
    description = "aurora engine"
}

variable "engine_mode" {
    type = string
    description = "aurora engine mode"
}

variable "engine_version" {
    type = string
    description = "aurora engine version"
}

variable "database_name" {
    type = string
    description = "aurora database name"
}

variable "master_username" {
    type = string
    description = "aurora engine master username"
}

variable "min_capacity" {
    type = number
    description = "aurora min capacity"

}

variable "max_capacity" {
    type = number
    description = "aurora max capacity"
}

variable "storage_encrypted" {
    type = bool
    default = true
    description = "aurora storage encryption mode"
}

variable "availability_zones" {
    type = list(string)
    default = [
        "us-east-1a",
        "us-east-1b",
        "us-east-1c"
    ]
    description = "aurora availability zones"
}

variable "subnet_group_name" {
    type = string
    description = "aurora subnet group name"
}

variable "subnet_ids" {
    type = list(string)
    default = []
    description = "aurora list of subnet ids"
}

variable "password_secret_manager" {
    type = string
    description = "aurora password secret manager"
}

variable "final_snapshot_identifier" {
    type = string
    description = "aurora final snapshot identifier"
}




