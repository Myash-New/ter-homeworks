resource "yandex_compute_instance" "web" {
  count       = var.web_instance_count
  name        = "${var.web_instance_name}-${count.index + 1}"
  platform_id = var.web_platform_id

  resources {
    cores         = var.web_cores
    memory        = var.web_memory
    core_fraction = var.web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.web_image_id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
 depends_on = [
    yandex_vpc_security_group.example,
    yandex_compute_instance.db
  ]
}