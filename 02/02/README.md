# Задача 1

![YC](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/task02terraform_YC_IP_task1.jpg)

![Curl](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/task02terraform_curl_IP.jpg)


1. preemptible = true (прерываемые ВМ)
Прерываемые ВМ  — это экземпляры, которые работают значительно дешевле обычных, но могут быть автоматически остановлены облачным провайдером в любой момент (например, при нехватке ресурсов).
Стоимость таких ВМ ниже на 60–90%, что полезно для учебных проектов, где бюджет ограничен (например, для студентов или стартапов).

2. core_fraction = 5 (доля vCPU)
Параметр указывает, какую долю вычислительных ресурсов CPU получит ВМ. Например, core_fraction = 5 в Yandex Cloud означает, что виртуальное ядро (vCPU) будет использовать только 5% от производительности физического ядра.
Уменьшение затрат на вычисления для задач, не требующих высокой производительности CPU.

Комбинация preemptible и core_fraction позволяет создать крайне дешевую, но нестабильную ВМ.

# Задача 2

![task2](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/task02terraform_task2.jpg)

<details>
  <summary>main.tf</summary>
  
```
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id

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
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat    
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
```
</details>

<details>
  <summary>variables.tf</summary>
  
```

###cloud vars

#yandex_compute_image

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}
#yandex_compute_instance

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "CPU cores"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "% of CPU usage"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible ON"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Nat ON"
} 


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDk4/+bLOZvAX1LH+uQDvG4RrQNFquSpO43XIWyZ0P95nar43cCEQ1fT58bXcJbtuxTLmf8ifKUIS1lQcR11eNTkSKhKHlgFGEhF+urLBkrI4rKRJtdt3Q0xUG1zTXs3FeHkU65PxXzDsmqI8UEWqBcNsn0CrPHhWO6OwjfCNUmHHgRudEn3QRndq6djQWWs4+3FgcEhuzPiXLES/ma66mTUmd+ApuGSEwXScBysWQIaW5t1wKB+sGq26V/Vt9jWMu05dQWAHqf/JjsXd+vV6ygjnSLiei60D/KCURqsxAsAlk1f3iGiMFtQVm1XPpRrzwU8E7QcgYFL8w8xYkAofR9B9uN30Ni23pCfxyGTakh1B32cOzHNps5ZGJ7rEdOCj/f1rpz9b6mMw2ExrbBJYtKcCCwBlqcU6pTDqxU0QGpDpIpV66BasDnKE6ZZeGO1WpXm5EoOXwFzLilvNpwxQMl04U0WQidS5wbjaoU15yfNLHmG0BKXQal8aZB6xoWudc="
  description = "ssh-keygen -t ed25519"
}

```
</details>

# Задача 3

![task3](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/task02terraform_VM_db_task3.jpg)

<details>
  <summary>main.tf</summary>
  
```
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_network" "db" {
  name = var.vpc_db_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_id

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
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat    
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

zone = var.web_zone
}

#db

resource "yandex_vpc_subnet" "db" {
  name           = var.vpc_db_name
  zone           = var.db_zone
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.db_cidr
}

resource "yandex_compute_instance" "db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_nat
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

  zone = var.db_zone
}
```
</details>

<details>
  <summary>variables.tf</summary>
  
```

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
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

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDk4/+bLOZvAX1LH+uQDvG4RrQNFquSpO43XIWyZ0P95nar43cCEQ1fT58bXcJbtuxTLmf8ifKUIS1lQcR11eNTkSKhKHlgFGEhF+urLBkrI4rKRJtdt3Q0xUG1zTXs3FeHkU65PxXzDsmqI8UEWqBcNsn0CrPHhWO6OwjfCNUmHHgRudEn3QRndq6djQWWs4+3FgcEhuzPiXLES/ma66mTUmd+ApuGSEwXScBysWQIaW5t1wKB+sGq26V/Vt9jWMu05dQWAHqf/JjsXd+vV6ygjnSLiei60D/KCURqsxAsAlk1f3iGiMFtQVm1XPpRrzwU8E7QcgYFL8w8xYkAofR9B9uN30Ni23pCfxyGTakh1B32cOzHNps5ZGJ7rEdOCj/f1rpz9b6mMw2ExrbBJYtKcCCwBlqcU6pTDqxU0QGpDpIpV66BasDnKE6ZZeGO1WpXm5EoOXwFzLilvNpwxQMl04U0WQidS5wbjaoU15yfNLHmG0BKXQal8aZB6xoWudc="
  description = "ssh-keygen -t ed25519"
}
```
</details>


<details>
  <summary>vms_platform.tf</summary>

```
###cloud web vars

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "web_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}
#yandex_compute_instance

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "CPU cores"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "% of CPU usage"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible ON"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Nat ON"
} 

variable "web_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Zone for VM web"
}

###cloud db vars

variable "vpc_db_name" {
  type        = string
  default     = "db"
  description = "VPC network & subnet name"
}

variable "db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image of VM"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM db name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "CPU cores"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Memory"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "% of CPU usage"
}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "preemptible ON"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "Nat ON"
}

variable "db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for VM db"
}

```
</details>

# Задача 4

![task4](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/Task%204.jpg)

# Задача 5
<details>
  <summary>vms_platform.tf</summary>

```
locals {
  vm_web_name = "${var.vm_web_name}-${var.web_zone}-web"
  vm_db_name = "${var.vm_db_name}-${var.db_zone}-db"
}
```
</details>

![task5](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/Task%205.jpg)


# Задача 6

![task6](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/Task6.jpg)


# Задача 7

<details>
  <summary>terraform_console</summary>

```
>local.test_list[1]
"staging"  

> length(local.test_list)
3  

> local.test_map["admin"]
"John"  

> "${local.test_map["admin"]} is admin for ${local.test_list[2]} server based on OS ${local.servers["production"].image} with ${local.servers["production"].cpu} vcpu, ${local.servers["production"].ram} ram and ${length(local.servers["production"].disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"  
```
</details>


![task7](https://github.com/Myash-New/ter-homeworks/blob/main/02/02/task%207.jpg)


