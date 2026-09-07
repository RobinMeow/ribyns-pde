# fedora setup

refer to arch-setup.md
you can skip most of it. but install gpu and cpu stuff.

```sh
# nvidia gpu drivers
sudo dnf install --assumeyes \
  akmod-nvidia-open
```

## nvidia

WARN: ensure your kernels are up2date.
`sudo dnf update`
`sudo dnf upgrade --refresh`
becuase nvidia will will the latests ones in, as needed.
but then fail and ruin sound/bluetooth and much more.
and rebuilding manually wont work.
so update, reboot. and only then install nvidia
`sudo dnf install akmod-nvidia-open`
watch akmod processes in btop after install.
its still doing stuff in the background, patiently wait for them.
5-10min on fast machine.

`akmod-nvidia-open` vs `kmod-nvidia-open`
akmod is auto-compiled on the machine, when kernels update.
very good.
kmod is pre-built. not as realiable.

> WARN: installing nvdidia kernels can screw up sound and bluetooth.

optionally cuda (recommended):
`sudo dnf install xorg-x11-drv-nvidia-cuda`

> how I fixed it:
sudo dnf rm '*nvidia*'
sudo dnf install 'akmod-nvidia-open'
did a bunch of other things as well. but its just essentially update
latest kernels. reboot using those kernels. and only then install gpu drivers.

## sound

didnt need to set these up, after fixing nvidia.

## bluetooth

didnt need to set these up, after fixing nvidia.

## cpu

apparently its not needed. but internet research
is outdated for this, since I have minimal fedora installation.
which has a small footprint and does not include defaults like the
other stuff. e.g. workstation.
intel `sudo dnf install microcore_ctl`

## Updates

`dnf update` and `dnf up` are aliases for `upgrade`

updating repository lists:
they are updated automatically from time to time.
to refresh the repository list immediatly use
`dnf upgrade --refresh`

## security updates

security updates can be pulled in isolation:
with the `--security` flag

```sh
# get security updates only
sudo dnf upgrade --security

# get the absolute late security updates
sudo dnf upgrade --refresh --security
```

in general its recommended to just run regular updates
`sudo dnf upgrade`
becuase only updating security patches increases the risk
of dependecy breakages.
optionally, to get the absolute latest security updates
`sudo dnf upgrade --refresh`
