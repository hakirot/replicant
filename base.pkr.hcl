
# BASE VM ARCH INSTALL

source "qemu" "base" {
  vm_name      = "arch-base"
  cpus         = 2
  iso_url      = "./archlinux-x86_64.iso"
  iso_checksum = "file:./checksum"
  output_directory = "output-arch-base"
  disk_size    = "20000"
  format       = "qcow2"
  http_directory = "http"
  memory       = 4096
  ssh_username = "username"
  ssh_password = "asdf"
  ssh_timeout = "20m"
  boot_wait = "120s"
  qemu_binary = "/usr/bin/qemu-system-x86_64"
  headless = false
  accelerator = "kvm"
  boot_command = [
#   "export PACKER_HTTP_IP={{ .HTTPIP}}<enter>",
#   "export PACKER_HTTP_PORT={{ .HTTPPort}}<enter>",
#   "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
#   "chmod +x install.sh<enter>",
#   "./install.sh --SIM<enter>"
  ]
}

build {
  sources = ["source.qemu.base"]

  provisioner "file" {
    source = "http/bash_profile"
    destination = "/home/username/.bash_profile"
  }
}
