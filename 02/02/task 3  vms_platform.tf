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