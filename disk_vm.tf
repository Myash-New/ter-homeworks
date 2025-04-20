resource "yandex_compute_disk" "disks" {
  count        = 3
  name         = "disk-${count.index + 1}"
  size         = 1
  type         = "network-hdd"
  zone         = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd84b1mojb8650b9luqd"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks[*]
    content {
      disk_id = secondary_disk.value.id
    }
  }
  depends_on = [yandex_compute_instance.storage]
}