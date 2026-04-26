FEDORA_ISO=${ISO_PATH:-"$HOME/Downloads/Fedora-Workstation-Live-43-1.6.x86_64.iso"}
# NOTE: fedora requires at least 8GB for base installation
virt-install \
	--name fedora-base \
	--memory 4096 \
	--cpu=host-passthrough \
	--cdrom "$FEDORA_ISO" \
	--os-variant=fedora43 \
	--disk size=16,format=qcow2,bus=virtio \
	--network user \
	--virt-type kvm
