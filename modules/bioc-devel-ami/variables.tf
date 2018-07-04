variable "instance_type" {
  description = "The instance type"
  default = "r4.xlarge"
}

variable "instance_name" {
  description = "The instance base name"
  default = "bioc-devel"
}

variable "key_name" {
  description = "This is the default port on which jupyter is running"
  default = "EveryDay"
}

variable "count" {
  description = "The number of instances to start"
  default = 1
}
