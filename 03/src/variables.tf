###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "security_group" {
  type        = list(string)
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image name"
}

variable "vm_web_instance_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform name"
}

variable "disk_count" {
  type    = number
  default = 3
}

variable "vm_web_count" {
  type    = number
  default = 2
}

variable "vm_web_cores" {
  type    = number
  default = 2
}

variable "vm_web_memory" {
  type    = number
  default = 1
}

variable "vm_web_core_fraction" {
  type    = number
  default = 20
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7XqdYdkvGDBbKJNcT6TxvjS2APmosSKfSZdSdYCsYX rikolleti@compute-vm-2-2-30-hdd-1751355561681"
  description = "ssh-keygen -t ed25519"
}
