# -- Setup Packer Build Environment
#TODO: compare checksums and download latest when not matching
wget --timestamping https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt
wget --timestamping https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso
head -n 1 sha256sums.txt | cut -f 1 -d " " > checksum
cat checksum
