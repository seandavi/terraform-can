variable "instance_type" {
  description = "The instance type"
  default = "m5.xlarge"
}

variable "key_name" {
  description = "This is the default port on which jupyter is running"
  default = "CSHLData.2015"
}

variable "boot_disk_size" {
  description = "The boot disk size in gb"
  default = 250
}
