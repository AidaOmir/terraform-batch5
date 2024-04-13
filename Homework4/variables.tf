variable ami_id {
    description = "Provide ami id"
    default = "ami-0900fe555666598a2"
    type = string
}

variable  instance_type {
    description = "Provide instance type"
    type = string
}

variable region {
    description = "Provide region"
    default = "us-east-2"
    type = string
}

variable key_name {
    type = string
    description = "Provide key_name" 
}
variable ports {
    type = list(number)
    description = "Provide ports"
    default = [22, 80, 443]
}

variable availability_zone {
    type = string
    description = "Provide availability zone"
}

variable count_number {
    type = string
    description = "Provide count_number"
}
variable "aws_security_group_ids" {
  description = "Provide VPC security group IDs"
  type        = list(string)
  default     = []
}
