source "qemu" "replicant" {
  vm_name           = "SARA"
  cpus              = 2
  iso_url           = "./output-arch-base/arch-base"
  disk_image        = true
  iso_checksum      = "none"
  output_directory  = "output-replicant"
  disk_size         = "20000"
  memory            = 4096
  format            = "qcow2"
  http_directory    = "http"
  ssh_username      = "username"
  ssh_password      = "asdf"
  ssh_timeout       = "60m"
  qemu_binary       = "/usr/bin/qemu-system-x86_64"
  headless          = false
  accelerator       = "kvm"
  qemuargs = [
    ["-monitor", "unix:/tmp/packer-qemu-monitor.sock,server,nowait"],
  ]

}

build {
  sources = ["source.qemu.replicant"]

  provisioner "shell" {
    script = "./http/replicate.sh"
  }
}
