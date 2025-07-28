###cloud vars

#SECOND_SERVER
variable "default_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VPC network & subnet name"
}

variable "vm_db_image_name" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_db_instance_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform name"
}

variable "vm_db_cores" {
  type    = number
  default = 2
}

variable "vm_db_memory" {
  type    = number
  default = 2
}

variable "vm_db_core_fraction" {
  type    = number
  default = 20
}
