variable "secret_key" {
  description = "secret key"
  type = string
}

variable "access_key" {
  description = "access key"
  type = string
}

variable "region" {
    type = string
    description = "aws region"
    default = "us-east-1"
}
# custom VPC variable
variable "vpc_cidr" {
  description = "custom vpc CIDR notation"
  type        = string
  default     = "10.0.0.0/16"
}


# public subnet 1 variable
variable "public_subnet1" {
  description = "public subnet 1 CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}

# public subnet 2 variable
variable "public_subnet2" {
  description = "public subnet 2 CIDR notation"
  type        = string
  default     = "10.0.2.0/24"
}

# AZ 1
variable "az1" {
  description = "availability zone 1"
  type        = string
  default     = "us-east-1a"
}


# AZ 2
variable "az2" {
  description = "availability zone 2"
  type        = string
  default     = "us-east-1b"
}
