source "qemu" "sara" {
  iso_url      = "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso"
  iso_checksum = "sha256:ENTER_THE_LATEST_CHECKSUM_HERE"
  output_directory = "output-qemu"
  disk_size    = "20000"
  format       = "qcow2"
  boot_command = [
    "<wait10><enter><wait><enter><f12><wait>linux archisobasedir=arch cow_spacesize=10G console=ttyS0<enter><wait>"
  ]
  qemu_binary = "/usr/bin/qemu-system-x86_64"
  headless = true
  accelerator = "kvm"
}

build {
  sources = ["source.qemu.archlinux"]
}
