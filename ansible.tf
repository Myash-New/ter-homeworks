resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible_inventory"
  content  = templatefile("${path.module}/ansible_inventory_file.tpl", {
    webservers = [
      for vm in yandex_compute_instance.web :
      {
        vm_name     = vm.name
        external_ip = vm.network_interface[0].nat_ip_address
        fqdn        = vm.fqdn
      }
    ]
    databases = [
      for vm in yandex_compute_instance.db :
      {
        vm_name     = vm.name
        external_ip = vm.network_interface[0].nat_ip_address
        fqdn        = vm.fqdn
      }
    ]
    storages = [
      {
        vm_name     = yandex_compute_instance.storage.name
        external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
        fqdn        = yandex_compute_instance.storage.fqdn
      }
    ]
  })
}