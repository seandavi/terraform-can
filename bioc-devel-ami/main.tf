module "bioc" {
  source = "../modules/bioc-devel-ami"
}

output "bioc_ip" {
  value = ["${module.bioc.public_ips}"]
}