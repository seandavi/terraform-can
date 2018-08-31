variable "instance_type" {
  description = "The instance type"
  default = "m5.large"
}

variable "instance_name" {
  description = "The instance base name"
  default = "mongodb"
}

variable "key_name" {
  description = "This is the default port on which jupyter is running"
  default = "EveryDay"
}

variable "count" {
  description = "The number of instances to start"
  default = 1
}
