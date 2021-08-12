variable "aws_region" {
    default = "ap-southeast-1"
}

variable "vpc_spoke_a_cidr" {
  default     = "10.251.0.0/16"
}

variable "vpc_spoke_b_cidr" {
  default     = "10.252.0.0/16"
}

variable "vpc_ingress_cidr" {
  default     = "10.1.0.0/16"
}

variable "cpversion" {
    default = "R80.40"
}

variable "management_server_size" {
    default = "m5.xlarge"
}

variable "geocluster_gateway_size" {
    default = "c5.large"
}

variable "project_name" {
    default = "Lab"
}

variable "key_name" {
    default = "tpot"
}

variable "sickey" {
    default = "vpn12345"
}

#Please use "openssl passwd -1" to create a password hash and copy it to here.
variable "password_hash" {
    default = "$1$CK9jJ4Sw$JXuJgThRUbslUqGBaC5nK1"
}
