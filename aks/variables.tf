variable "cluster_name" {
  default     = "learnk8scluster"
}

variable "env_name" {
  default     = "dev"
}

variable "instance_type" {
  default = "standard_d2_v2"
}

variable "helm_name" {
  description = "helm name chart"
}

variable "set_username" {
  description = "setting username for helm chart"
}

variable "set_password" {
  description = "setting password for helm chart"
}

variable "username" {
  default     = "admin"
  sensitive = true
}

variable "password" {
  default     = "Test@1234"
  sensitive = true
}