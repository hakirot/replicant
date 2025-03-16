#TODO: compare checksums and download latest if not matching
wget --timestamping https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt
wget --timestamping https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso
export PKR_VAR_iso_checksum = $(head -n 1 sha256sums.txt | cut -f 1 -d " ")
