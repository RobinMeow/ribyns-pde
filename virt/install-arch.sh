virt-install \
	--name archlinux-base \
	--memory 4096 \
	--cpu=host-passthrough \
	--cdrom "$HOME/Downloads/archlinux-x86_64.iso" \
	--osinfo detect=on,name=archlinux \
	--disk size=10,format=qcow2,but=virtio \
	--network user \
	--virt-type kvm
