## GPU GTX 4080S and Mainboard MSI Z890 Edge struggle

connect to wifi using iwctl and then download the chipset for msi Z890 mainboard
Intel® Killer™ E5000B 5G LAN
Vendor Device ID [10ec:5000]
Kernel driver in use: r8169
Kernel modules: r8169, r8129
> endded up not needing them or sth idk. i still used my old usb drive and installed using wifi instead. after install it just worked. again using r8169.
NV190 family (Ada Lovelace)
Code name	Official Name
NV192 (AD102)	GeForce RTX 4090
NV193 (AD103)	GeForce RTX 4080 < MINE
NV194 (AD104)	GeForce RTX (4070, 4070 Ti)
NV196 (AD106)	GeForce RTX 4060 Ti
NV197 (AD107)	GeForce RTX 4060

those work, but arent the official supported ones, becase this network adapter is only supported for win10 and 11
arch wiki which explains how to load your needed module: https://wiki.archlinux.org/title/Network_configuration/Ethernet

## Partition and format disk

> `lsblk` lets you see your current drives

enter paritioning your desired disk `fdisk /dev/<yourdisk>`
using nvme1n1 as example onwards

delete all existing ones with `d`, than `g` for a new gpt table

`n` for a new partition, use defaults, but for last sector use `+1G`, remove signature is fine if asked
`t` to set the type to `1` (efi)

`n` -> last sector `+4G`
`t` -> 2nd partition `19` (linux swap)

`n` -> defaults (use rest of available space)
`t` -> 3rd partition -> `23` linux root (x86-64)
`w` -> to write all to disk (the cmds so far were done in a memory transactions which can still be discarded. `w` will commit the transaction)

format them

1. `mkfs.ext4 /dev/nvmen1n1p3`
2. `mkswap /dev/nvme1n1p2`
3. `mkfs.fat -F 32 /dev/nvme1n1p1`

mount them

`mount --mkdir /dev/nvme1n1p3 /mnt`
`mount --mkdir /dev/nvme1n1p1 /mnt/boot`
`swapon /dev/nvme1n1p2`

install essential packages 

`pacstrap -K /mnt base linux linux-firmware`
> could show error because of missing vconsole.conf which we are about to create

some of these might not be available if you dont have a running internet connection
and all further packages as desired:
`pacstrap -K /mnt base-devel git networkmanager vim zsh`

intel or amd cpi (ucode) amd/intel-ucode
`pacstrap -K /mnt intel-ucode`

help pages
`pacstrap -K /mnt man man-db man-pages texinfo`
also `info` if it works

`genfstab -U /mnt >> /mnt/etc/fstab`
`arch-chroot /mnt`
`ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime`
`hwclock --systohc`
`timedatectl set-ntp true`

`locale-gen`
`vim /etc/locale.conf`
"LANG=en_US.UTF-8"
`vim /etc/vconsole.conf`
`KEYMAP=us` (or `de` for qwertz)

`vim /etc/hostname`
"ribyn" or any other network hostname, only lowercase

initramfs

`okinitcpio -P`

`passwd`
to set your root password

time for grub bootloader
https://wiki.archlinux.org/title/GRUB
`pacman -S grub efibootmgr`
assuming your still chrooted (as you should be)
`grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`
`grub-mkconfig -o /boot/grub/grub.cfg`
exit and reboot

dual boot with existing windows on seperate drive?
before running grub-mkconfig enable the os-prober to have grub-mkconfig automatically detect windows and add it to the boot menu entries:
`pacman -S os-prober`
you need to mount the windows efi partition so the os-prober will actually find it. and also change some file to allow the prober to run.
see arch wiki for more info.
I ended up running grub install and mkconfig a few times and got a GRUB entry point in arch/boot/EFI/GRUB and in windows/boot/EFI/GRUB and idk which one is used now.
only worked after going into uefi settings with DEL and changing the boot order there on the harddisk section. Boot > Harddisk and then set grub first


your new system on reboot. log into root.
run `systemctl enable NetworkManager.service`
to make sure it starts on every boot
and run `systemctl start NetworkManager.service` to start it now and to establish internet connection without rebooting now
and gpu drivers, if pacman -S nvidia is for the 4080 (nvidia is precomiled, consider compiling yourself using dkms)

visudo and uncomment the sudo line
`groupadd sudo`

create a new user 
`useradd -m -G sudo -s /usr/bin/zsh ribyn`
`-m` make home directory
`-G` add to group named sudo
`-s` default shell

exit root login into user and set up ribyns-pde for nicer shell

then set up desktop environment

`pacman -S plasma-desktop` (this is the minimal one, but still contains kwallet which we will disable later)
choose `pipewire-jack`
than choose `ffmpeg` as the "safer default" gstreamer can be installed additionally later apparently
`pacman -S sddm`
for a display manager
enable it on boot up `systemctl enable sddm.service`
if you reboot now it will start sddm and have selected wayland be default
Quick settings > Breeze Dark (Dark mode essentially)
install a browser:
`yay google-chrome`
run it with `google-chrome-stable`
`vim ~/.config/kwalletrc` and add
```
[Wallet]
Enabled=false
```
you can set the background to the image in the ribyns-pde repo.


the second monitor worked after installing nvidia drivers and running mudprobe nvidia. it than worked on restart as well.

### KDE

install `pacman -S kscreen` which allows you to rearrange monitors and do some resolution settings etc.

install `sddm-kcm` which allows configuring the login screen
when setting this as default make sure you got its deps `pacman -S qt5-declarative qt5‑graphicaleffects qt5‑quickcontrols2 qt5‑svg`
go to login sddm and install eucalyptus drop and change its background to the arch image
as splash screen install kuro the cat


next up: sound!
`pacman -S `(any sorts of piprewires and wireplumbers you can find)
and
`pacman -S plasma-pa`
which is the speaker in the systemstray and other sound settings

bluetooth
`pacman -S bluez bluez-utils`
and for kde specific
`bluedevil`
`systemctl enable --now bluetooth.service`
enable auto starts it at start up. --now is like `start` to start it immediatly

## KDE System Settings

- Mouse > disable acceleration (on all mouses)
- screen edge barrier to zero pixel (so slow movement when trying to cross screen doesnt get blocked)
- Mouse > enable Hold down middle button and move mouse to scroll (only important for the tackball)
- set lock screen background image
- sddm login and transition animations are described above i think

## Arch Defaults:

- uncomment the `#Color` in `/etc/pacman.confg` _(enabled colored outputs for pacman cmds and yay)_

`pacman -S`:
- `bat` cat with wings
- `lnav` logfile navigator
- `tealdeer` `tldr`

### Laptop

**tlp (battery power management):**
`sudo systemctl start --enable tlp`
set bat0 thresholds to 50/65 recommended here https://gurkhatech.com/laptop-battery-best-usage-guide/?utm_source=chatgpt.com if you can be pluggedin most of the time
do so by `sudo vim /etc/tlp.conf` and search for `START_CHARGE` and `STOP_CHARGE`

## Git

ssh
`ssh-keygen -t rsa -b 4096 -C "ribyns-pde@example.com"`
`ssh-keyscan -H github.com >> ~/.ssh/known_hosts`

# TODO

## system maintenance
i plan to read the news feed to prevent updating when news says other wise
would like some rollback functionality, or automated backups.
https://wiki.archlinux.org/title/System_maintenance#Read_before_upgrading_the_system
