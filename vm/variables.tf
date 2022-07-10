variable "env_name" {
  description = "environemnt name"
  default     = "dev"
}

variable "location" {
  description = "resource group location"
  default     = "japan east"
}

variable "totalvm" {
  description = "Number of vm to create"
}

variable "subnet" {
  description = "ip address prefix"
}

variable "username" {
  description = "username linux"
  default     = "admin"
  sensitive = true
}

variable "password" {
  description = "password linux"
  default     = "Test@1234"
  sensitive = true
}