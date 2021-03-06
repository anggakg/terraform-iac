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

variable "vm_size" {
  description = "spec vm"
}

variable "subnet" {
  description = "ip address prefix"
}

variable "username" {
  description = "username linux"
  default     = "teestadmin"
  sensitive = true
}

variable "password" {
  description = "password linux"
  default     = "Test@1234"
  sensitive = true
}