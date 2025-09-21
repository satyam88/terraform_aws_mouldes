variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Database master username"
}

variable "db_password" {
  type        = string
  description = "Database master password"
  sensitive   = true
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  type        = string
  default     = "8.0"
}

variable "vpc_security_group_ids" {
  type        = list(string)
}

variable "subnet_ids" {
  type        = list(string)
}