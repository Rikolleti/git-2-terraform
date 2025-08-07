resource "yandex_compute_disk" "my_disks" {
  count = 3
  name  = "disk-${count.index}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 1
}

locals {
  disks_map = {
    for idx, disk in yandex_compute_disk.my_disks :
    idx => disk
  }
}

data "yandex_compute_image" "ubuntu_storage" {
  family = var.vm_web_image_name
}

resource "yandex_compute_instance" "storage" {
  name         = "netology-develop-platform-storage"
  zone         = var.default_zone
  platform_id  = var.vm_web_instance_platform

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_storage.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = local.disks_map
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = var.security_group
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.public_key}"
  }
}
