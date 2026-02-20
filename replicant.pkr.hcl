
# FULL VM ARCH INSTALL

source "qemu" "replicant" {
  vm_name      = "replicant"
  cpus         = 2
  iso_url      = "./archlinux-x86_64.iso"
  iso_checksum = "file:./checksum"
  output_directory = "output-replicant"
  disk_size    = "20000"
  format       = "qcow2"
  http_directory = "http"
  memory       = 4096
  ssh_username = "username"
  ssh_password = "asdf"
  ssh_timeout = "60m"
  boot_wait = "120s"
  qemu_binary = "/usr/bin/qemu-system-x86_64"
  headless = false
  accelerator = "kvm"
  boot_command = [
# OPTION 1: Pull in local files (deprecated)
#   "export PACKER_HTTP_IP={{ .HTTPIP}}<enter>",
#   "export PACKER_HTTP_PORT={{ .HTTPPort}}<enter>",
#   "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
#   "chmod +x install.sh<enter>",
#   "./install.sh username --SIM<enter>"
#
# OPTION 2: Pull scripts from production server
    "sh -c \"$(curl -fsSL https://www.cachecoyotes.com/replicant)\"<enter>"
  ]
  qemuargs = [
    ["-monitor", "unix:/tmp/packer-qemu-monitor.sock,server,nowait"],
  ]
}

build {
  sources = ["source.qemu.replicant"]

  provisioner "file" {
    source = "http/bash_profile"
    destination = "/home/username/.bash_profile.packer.bak"
  }
}
