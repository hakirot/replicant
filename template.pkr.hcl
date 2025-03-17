source "qemu" "sara" {
  iso_url      = "./archlinux-x86_64.iso"
  iso_checksum = "file:./checksum"
  output_directory = "output-sara"
  disk_size    = "20000"
  format       = "qcow2"
  http_directory = "http"
  memory       = 4096
  ssh_username = "root"
  ssh_password = "asdf"
  ssh_timeout = "120m"
  boot_wait = "5s"
  qemu_binary = "/usr/bin/qemu-system-x86_64"
  headless = false
  accelerator = "kvm"
  boot_command = [
    "<wait10><enter><wait><enter><f12><wait>linux archisobasedir=arch cow_spacesize=10G console=ttyS0<enter><wait20>",
    "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/user_configuration.json<enter>",
    "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/user_credentials.json<enter>",
    "curl -O {{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>"
    "chmod +x install.sh"
    "./install.sh"
  ]
}

build {
  sources = ["source.qemu.sara"]
}

variable "iso_checksum" {
  type = string
  default = "none"
}

