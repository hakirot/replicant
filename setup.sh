# -- Setup Packer Build Environment
#TODO: compare checksums and download latest when not matching
wget -q --timestamping https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt
wget -q --timestamping https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso
head -n 1 sha256sums.txt | cut -f 1 -d " " > iso_checksum
rm sha256sums.txt
cat iso_checksum
