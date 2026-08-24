
# FULL VM ARCH INSTALL

source "qemu" "replicant" {
  vm_name      = "replicant"
  cpus         = 2
  iso_url      = "./archlinux-x86_64.iso"
  iso_checksum = "file:./iso_checksum"
  output_directory = "output-replicant"
  disk_size    = "20000"
  format       = "qcow2"
  http_directory = "http"
  memory       = 4096
  ssh_username = "hakirot"
  ssh_password = "asdf"
  ssh_timeout = "60m"
# boot_wait = "180s"
  boot_wait = "40s"
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
    "archinstall<enter>",
    "<wait10>",
    "jj<enter><enter>",
    "<wait10>",
    "kkkk<enter>",
    "k<enter>",
    "j<enter><enter><enter><enter>j<enter>k<enter>",
    "jjjjj<enter><enter>",
    "asdf<enter>",
    "asdf<enter>",
    "j<enter><enter>",
    "hakirot<enter>",
    "asdf<enter>",
    "asdf<enter><enter>jj<enter>jj<enter>",
    "j<enter><enter>k<enter>k<enter>",
    "jj<enter><enter>",
    "jjj<enter>kk<enter>",
    "jj<enter><enter>.<enter><enter><enter><enter>j<enter>.<enter><enter><enter>jj<enter>",
    "<wait2>",
    "ls<enter>",
    "curl --proto '=https' https://www.hakipaks.org/replicant/start | sh<enter>",
    "<wait10>",
    "y",
  ]
  qemuargs = [
    ["-monitor", "unix:/tmp/packer-qemu-monitor.sock,server,nowait"],
  ]
}

build {
  sources = ["source.qemu.replicant"]

  provisioner "file" {
    source = "http/bash_profile"
    destination = "/home/hakirot/.bash_profile.packer.bak"
  }
}
