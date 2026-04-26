# VM

using qemu, kvm, libvirt

use `virsh` to manage vms (shutdown, boot up, ...)
comes with `libvirt`
or `virt-manager` as gui for managing (seperate install)

use `virt-viewer` as gui app to operate visually in a vm
or `ssh` to operate in the vm using the terminal

use `virt-clone` to create clone based on an existing file-system of a vm

`virt-install` to create vm's manually or using scripts


`sudo systemctl start libvirtd`


## Quick Reference

1.  **Start Service**: `sudo systemctl start libvirtd`
2.  **Start VM**: `virsh start <vm_name>`
3.  **Stop VM**: `virsh shutdown <vm_name>` (graceful) or `virsh destroy <vm_name>` (force).
4.  **List**: `virsh list --all`

> Using the `install-arch.sh` script uses the original iso for a normal install.
> Not completing the install will result in an useable vm, because it cannot boot

use the scripts for normal installation. You can install onto vda (the image file in ~/.local/share/libvirt/images/)
then your base vm is ready. before doing further things.
use virt-clone to clone the base over and over again, so you can start on fresh installs.
virt-clone --original fedora-base --name fedora --file "$HOME/.local/share/libvirt/images/fedora.qcow2"
