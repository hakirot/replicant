source "qemu" "replicant" {
  vm_name           = "SARA"
  iso_url           = "./output-arch-base/arch-base"
  disk_image        = true
  iso_checksum      = "none"
  output_directory  = "output-replicant"
  disk_size         = "30000"
  memory            = 4096
  format            = "qcow2"
  http_directory    = "http"
  ssh_username      = "username"
  ssh_password      = "asdf"
  ssh_timeout       = "20m"
  qemu_binary       = "/usr/bin/qemu-system-x86_64"
  headless          = false
  accelerator       = "kvm"
}

build {
  sources = ["source.qemu.replicant"]

  provisioner "shell" {
#   script = "./http/replicate.sh"
    inline = ["echo yay!"]
  }
}
