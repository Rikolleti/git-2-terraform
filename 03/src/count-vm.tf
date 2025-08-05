data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_name
}

resource "yandex_compute_instance" "web" {
  count = var.vm_web_count
  name = "netology-develop-platform-web-${count.index + 1}"
  zone =  var.default_zone
  platform_id = var.vm_web_instance_platform
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.vm_web_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = var.security_group
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.public_key}"
  }

  depends_on = [yandex_compute_instance.db]
}
