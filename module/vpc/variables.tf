variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}

variable "availability_zones" {
  type = set(object({
    az = string
    private_subnet_cidrs = list(string)
    public_subnet_cidrs = list(string)
  }))
  description = "Availability Zones"
  default = []
}
