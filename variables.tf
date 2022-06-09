variable "rg_name" {
  default     = "tfstate"
  sensitive = true
}

variable "storage_account_name" {
  default     = "tfstate22081"
  sensitive = true
}

variable "container_name" {
  default     = "tfstate"
  sensitive = true
}

variable "key" {
  default     = "terraform.tfstate"
  sensitive = true
}