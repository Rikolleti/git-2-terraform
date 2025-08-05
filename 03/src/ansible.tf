locals {
  web_hosts = [
    for vm in yandex_compute_instance.web :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  db_hosts = [
    for vm in values(yandex_compute_instance.db) :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  storage_hosts = [
    {
      name        = yandex_compute_instance.storage.name
      external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.storage.fqdn
    }
  ]

  rendered_inventory = templatefile("${path.module}/inventory.tpl", {
    web_hosts     = local.web_hosts
    db_hosts      = local.db_hosts
    storage_hosts = local.storage_hosts
  })
}

resource "local_file" "ansible_inventory" {
  content  = local.rendered_inventory
  filename = "${path.module}/for.ini"
}
