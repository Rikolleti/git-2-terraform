data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_web_image_name
}

resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = "db-${each.key}"
  zone        = var.default_zone
  platform_id = "standard-v3"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      size     = each.value.disk_volume
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.public_key}"
  }
}
