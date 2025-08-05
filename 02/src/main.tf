resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "db_develop" {
  name           = var.vpc_db_name
  zone           = var.default_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_db_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_name
}
resource "yandex_compute_instance" "platform" {
  name        = local.name
  platform_id = var.vm_web_instance_platform
  resources {
    cores         = var.vm_resources["platform"].cores
    memory        = var.vm_resources["platform"].memory
    core_fraction = var.vm_resources["platform"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    #serial-port-enable = 1
    #ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image_name
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.name_db
  platform_id = var.vm_db_instance_platform
  zone        = var.default_db_zone

  resources {
    cores         = var.vm_resources["platform_db"].cores
    memory        = var.vm_resources["platform_db"].memory
    core_fraction = var.vm_resources["platform_db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.db_develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
