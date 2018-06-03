# UEFI dual-booting

It's actually not hard, do the usual stuff, as with MBR:

  - install Windows,
  - systemrescuecd to your GNU/Linux,
  - lvm/cryptsetup/mount your root,
  - mount your `/boot` into your root,
  - bind mount `/dev`, `/dev/pts`, `/proc`, `/sys`,
  - NEW: you mount your EFI partition to `/boot/efi`,
  - chroot,
  - `grub-install /dev/sda`,
  - use `efibootmgr` to check what happened to your firmware.

This is when everything goes right, but how to debug if not?

## UEFI boot sequence

- There is some program built into your motherboard that boots,
- There is usually still a UI, although strictly speaking not needed,
- ISO images can be booted because of CSM,
- ISO images from pendrives can be booted after isohybrid,
- Hard drives can be booted if there is an EFI partition on them,
- But there can be multiple operating systems (even without GRUB).

Demo: `efibootmgr`.

## UEFI on MBR/GPT

Usually if you boot UEFI, you also use GPT for your disk partitions,
not MBR, but this is not a rule.  The UEFI standard supports booting
from MBR, you still need an extra partition though (that has to be
primary).

GRUB supports this, but please note that Windows 10 does not.

Also note that your disk will be limited to 2TB.

By the way:
https://www.digitec.ch/de/s1/product/samsung-enterprise-pm1633a-15360gb-25-ssd-8605079?tagIds=76

## You need money to make money

The `grub-install` and `efibootmgr` tools only work if you already
booted your machine in UEFI mode, not in Legacy.  You can verify this
by the existence of `/sys/firmware/efi`.

You can't even install Windows on GPT if you don't manage to boot in
UEFI mode.

What are your options if you really just can't?

Best option: try harder.  Try USB pendrive, try PXE, something WILL
BOOT in UEFI mode.

If you really can't, you can try to create everything on the disk as
if you were successful (in another machine, virtual machine, dd,
whatever) and name your grub efi file `bootx64.efi` on `/boot/efi`.

## `update-grub` and Windows (and VeraCrypt)

Once you manage to install both Windows and GNU/Linux, and you manage
to boot your GNU/Linux with UEFI, `update-grub` will just find the
Windows and add it to your boot menu, so all will be fine.

This is all managed by the `os-prober` package, if you ever have to
debug it.

For VeraCrypt, you have to apply my solution:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=857130

But please just simply buy the Pro license for $4 instead and use
BitLocker!
