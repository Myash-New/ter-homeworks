resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.db_vms : vm.vm_name => vm }

  name        = each.key
  platform_id = "standard-v3"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id  = each.value.image_id
      size      = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.nat
  }

   metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"

  }

  depends_on = [yandex_vpc_subnet.develop]
}
