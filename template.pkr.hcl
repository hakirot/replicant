source "qemu" "sara" {
  vm_name      = "SARA"
  iso_url      = "./archlinux-x86_64.iso"
  iso_checksum = "file:./checksum"
  output_directory = "output-sara"
  disk_size    = "20000"
  format       = "qcow2"
  http_directory = "http"
  memory       = 4096
  ssh_username = "username"
  ssh_password = "asdf"
  ssh_timeout = "20m"
  boot_wait = "5s"
  qemu_binary = "/usr/bin/qemu-system-x86_64"
  headless = false
  accelerator = "kvm"
  boot_command = [
    "<wait70>",
    "export PACKER_HTTP_IP={{ .HTTPIP}}<enter>",
    "export PACKER_HTTP_PORT={{ .HTTPPort}}<enter>",
    "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
    "chmod +x install.sh<enter>",
    "./install.sh<enter>"
  ]
}

build {
  sources = ["source.qemu.sara"]
}
