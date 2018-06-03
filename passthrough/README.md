# Virtual machines with PCI passthrough

The goal here is to run a virtualized OS, which can be used for
desktop purposes, so it has a real physical keyboard and mouse, USB
ports, good quality and performant video and audio with microphone.

We will achieve all this with a tech called "PCI passthrough".

Source for most of the presentation:
https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF

## Scenarios

Windows virtual machine for gaming.

Desktop on a server.

Multiseat.

## Useful hardware to buy

Display with built-in USB hub AND multiple digital inputs.

NVidia professional cards (or you will have to cheat).

Motherboard with a lot of CPU power, RAM and PCI x16 slots if you want
more than 1 VM.

Tip for Switzerland: http://www.benno-shop.com/, go to the Workstation
section and choose HP or Lenovo.  Choose from the most expensive ones
(~1000 CHF).

Mine has 32 GB RAM, Xeon E5-2650 v2, Quadro K4000 for 790 CHF.  It's a
ThinkStation C30 Workstation.

When opened, it has:

  - 8 more free RAM slots,
  - 1 more free CPU slot,
  - 4 more HDD/SSD bays,
  - very clean cabling,
  - instructions on the inside of the chassis.

It still has very good support from Lenovo (e.g. BIOS update for
Spectre/Meltdown).  The BIOS is very-very featureful compared to
Desktop machines.

It's also quite quiet.

Windows 10 Pro license that just works on the real hardware or can be
phone activated for QEMU/KVM.

Only drawback: no display ports on the motherboard, as you would have
with a self-built desktop.

## Preparations

Update grub with Linux command line options `net.ifnames=0 intel_iommu=on`.

OK, the `net.ifnames` is not needed, I just really like it :-)

After reboot in `dmesg`:

    May 26 14:21:15 mundo kernel: [    0.871062] iommu: Adding device 0000:00:00.0 to group 0
    May 26 14:21:15 mundo kernel: [    0.871134] iommu: Adding device 0000:00:01.0 to group 1
    May 26 14:21:15 mundo kernel: [    0.871204] iommu: Adding device 0000:00:01.1 to group 2
    May 26 14:21:15 mundo kernel: [    0.871272] iommu: Adding device 0000:00:02.0 to group 3
    May 26 14:21:15 mundo kernel: [    0.871340] iommu: Adding device 0000:00:03.0 to group 4
    May 26 14:21:15 mundo kernel: [    0.871471] iommu: Adding device 0000:00:04.0 to group 5
    May 26 14:21:15 mundo kernel: [    0.871537] iommu: Adding device 0000:00:04.1 to group 5
    May 26 14:21:15 mundo kernel: [    0.871602] iommu: Adding device 0000:00:04.2 to group 5
    May 26 14:21:15 mundo kernel: [    0.871668] iommu: Adding device 0000:00:04.3 to group 5
    May 26 14:21:15 mundo kernel: [    0.871733] iommu: Adding device 0000:00:04.4 to group 5
    May 26 14:21:15 mundo kernel: [    0.871799] iommu: Adding device 0000:00:04.5 to group 5
    May 26 14:21:15 mundo kernel: [    0.871865] iommu: Adding device 0000:00:04.6 to group 5
    May 26 14:21:15 mundo kernel: [    0.871931] iommu: Adding device 0000:00:04.7 to group 5
    May 26 14:21:15 mundo kernel: [    0.872019] iommu: Adding device 0000:00:05.0 to group 6
    May 26 14:21:15 mundo kernel: [    0.872086] iommu: Adding device 0000:00:05.2 to group 6
    May 26 14:21:15 mundo kernel: [    0.872152] iommu: Adding device 0000:00:05.4 to group 6
    May 26 14:21:15 mundo kernel: [    0.872218] iommu: Adding device 0000:00:11.0 to group 7
    May 26 14:21:15 mundo kernel: [    0.872313] iommu: Adding device 0000:00:16.0 to group 8
    May 26 14:21:15 mundo kernel: [    0.872378] iommu: Adding device 0000:00:16.1 to group 8
    May 26 14:21:15 mundo kernel: [    0.872444] iommu: Adding device 0000:00:16.2 to group 8
    May 26 14:21:15 mundo kernel: [    0.872509] iommu: Adding device 0000:00:16.3 to group 8
    May 26 14:21:15 mundo kernel: [    0.872575] iommu: Adding device 0000:00:19.0 to group 9
    May 26 14:21:15 mundo kernel: [    0.872641] iommu: Adding device 0000:00:1a.0 to group 10
    May 26 14:21:15 mundo kernel: [    0.872706] iommu: Adding device 0000:00:1b.0 to group 11
    May 26 14:21:15 mundo kernel: [    0.872771] iommu: Adding device 0000:00:1c.0 to group 12
    May 26 14:21:15 mundo kernel: [    0.872837] iommu: Adding device 0000:00:1c.4 to group 13
    May 26 14:21:15 mundo kernel: [    0.872902] iommu: Adding device 0000:00:1d.0 to group 14
    May 26 14:21:15 mundo kernel: [    0.872967] iommu: Adding device 0000:00:1e.0 to group 15
    May 26 14:21:15 mundo kernel: [    0.873063] iommu: Adding device 0000:00:1f.0 to group 16
    May 26 14:21:15 mundo kernel: [    0.873130] iommu: Adding device 0000:00:1f.2 to group 16
    May 26 14:21:15 mundo kernel: [    0.873197] iommu: Adding device 0000:00:1f.3 to group 16
    May 26 14:21:15 mundo kernel: [    0.873264] iommu: Adding device 0000:00:1f.6 to group 16
    May 26 14:21:15 mundo kernel: [    0.873352] iommu: Adding device 0000:03:00.0 to group 17
    May 26 14:21:15 mundo kernel: [    0.873425] iommu: Adding device 0000:03:00.1 to group 17
    May 26 14:21:15 mundo kernel: [    0.873507] iommu: Adding device 0000:05:00.0 to group 18
    May 26 14:21:15 mundo kernel: [    0.873572] iommu: Adding device 0000:07:00.0 to group 19
    May 26 14:21:15 mundo kernel: [    0.873645] iommu: Adding device 0000:3f:08.0 to group 20
    May 26 14:21:15 mundo kernel: [    0.873718] iommu: Adding device 0000:3f:09.0 to group 21
    May 26 14:21:15 mundo kernel: [    0.873813] iommu: Adding device 0000:3f:0a.0 to group 22
    May 26 14:21:15 mundo kernel: [    0.873881] iommu: Adding device 0000:3f:0a.1 to group 22
    May 26 14:21:15 mundo kernel: [    0.873949] iommu: Adding device 0000:3f:0a.2 to group 22
    May 26 14:21:15 mundo kernel: [    0.874016] iommu: Adding device 0000:3f:0a.3 to group 22
    May 26 14:21:15 mundo kernel: [    0.874097] iommu: Adding device 0000:3f:0b.0 to group 23
    May 26 14:21:15 mundo kernel: [    0.874165] iommu: Adding device 0000:3f:0b.3 to group 23
    May 26 14:21:15 mundo kernel: [    0.874266] iommu: Adding device 0000:3f:0c.0 to group 24
    May 26 14:21:15 mundo kernel: [    0.874335] iommu: Adding device 0000:3f:0c.1 to group 24
    May 26 14:21:15 mundo kernel: [    0.874403] iommu: Adding device 0000:3f:0c.2 to group 24
    May 26 14:21:15 mundo kernel: [    0.874471] iommu: Adding device 0000:3f:0c.3 to group 24
    May 26 14:21:15 mundo kernel: [    0.874567] iommu: Adding device 0000:3f:0d.0 to group 25
    May 26 14:21:15 mundo kernel: [    0.874636] iommu: Adding device 0000:3f:0d.1 to group 25
    May 26 14:21:15 mundo kernel: [    0.874704] iommu: Adding device 0000:3f:0d.2 to group 25
    May 26 14:21:15 mundo kernel: [    0.874773] iommu: Adding device 0000:3f:0d.3 to group 25
    May 26 14:21:15 mundo kernel: [    0.874854] iommu: Adding device 0000:3f:0e.0 to group 26
    May 26 14:21:15 mundo kernel: [    0.874923] iommu: Adding device 0000:3f:0e.1 to group 26
    May 26 14:21:15 mundo kernel: [    0.875035] iommu: Adding device 0000:3f:0f.0 to group 27
    May 26 14:21:15 mundo kernel: [    0.875104] iommu: Adding device 0000:3f:0f.1 to group 27
    May 26 14:21:15 mundo kernel: [    0.875174] iommu: Adding device 0000:3f:0f.2 to group 27
    May 26 14:21:15 mundo kernel: [    0.875245] iommu: Adding device 0000:3f:0f.3 to group 27
    May 26 14:21:15 mundo kernel: [    0.875316] iommu: Adding device 0000:3f:0f.4 to group 27
    May 26 14:21:15 mundo kernel: [    0.875385] iommu: Adding device 0000:3f:0f.5 to group 27
    May 26 14:21:15 mundo kernel: [    0.875513] iommu: Adding device 0000:3f:10.0 to group 28
    May 26 14:21:15 mundo kernel: [    0.875582] iommu: Adding device 0000:3f:10.1 to group 28
    May 26 14:21:15 mundo kernel: [    0.875652] iommu: Adding device 0000:3f:10.2 to group 28
    May 26 14:21:15 mundo kernel: [    0.875723] iommu: Adding device 0000:3f:10.3 to group 28
    May 26 14:21:15 mundo kernel: [    0.875793] iommu: Adding device 0000:3f:10.4 to group 28
    May 26 14:21:15 mundo kernel: [    0.875863] iommu: Adding device 0000:3f:10.5 to group 28
    May 26 14:21:15 mundo kernel: [    0.875934] iommu: Adding device 0000:3f:10.6 to group 28
    May 26 14:21:15 mundo kernel: [    0.876005] iommu: Adding device 0000:3f:10.7 to group 28
    May 26 14:21:15 mundo kernel: [    0.876099] iommu: Adding device 0000:3f:13.0 to group 29
    May 26 14:21:15 mundo kernel: [    0.876169] iommu: Adding device 0000:3f:13.1 to group 29
    May 26 14:21:15 mundo kernel: [    0.876240] iommu: Adding device 0000:3f:13.4 to group 29
    May 26 14:21:15 mundo kernel: [    0.876311] iommu: Adding device 0000:3f:13.5 to group 29
    May 26 14:21:15 mundo kernel: [    0.876399] iommu: Adding device 0000:3f:16.0 to group 30
    May 26 14:21:15 mundo kernel: [    0.876470] iommu: Adding device 0000:3f:16.1 to group 30
    May 26 14:21:15 mundo kernel: [    0.876541] iommu: Adding device 0000:3f:16.2 to group 30

Your video card (in this case 0000:03:00.0 and 0000:03:00.1 (video +
HDMI audio)) has to be in a separate group or you will have to pass
the grouped devices too, so you can only pass whole groups.  If you
have a PCI root bridge in the group, you don't have to pass that and
do not `vfio_pci` it.

Next step is to use `vfio_pci` module to reserve the to be passed PCI
IDs during boot.  Don't forget to `update-initramfs` and `reboot`.

## Installation

Use `virt-manager` to create a VM.

Important settings:
  - i440FX machine type (Q35 works too, but much less tested),
  - UEFI boot (a must!),
  - VirtIO for the network card (faster than RTL8139, but not a must),
  - IDE /dev/hda: Windows install disc,
  - IDE /dev/hdb: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.149-2/
  - VirtIO SCSI controller (a lot faster IO than emulated, but not a must),
  - SCSI /dev/sda: your virtual disk for the VM,
  - you can delete all the virtual video card, audio, USB redirector, Spice, etc.,
  - PCI passthrough your video card,
  - PCI passthrough your USB controller,
  - if you don't have a separate USB controller, PCI passthrough some devices instead.

Choose "Start installation", but kill the windows install right away,
we will first have to do some BIOS hacking.

## BIOS UUID and other hardware info copying

In case of a Linux guest you can skip this.

For Windows licensing use the `dump-bios.sh` script and then:

    <qemu:commandline>
      <qemu:arg value='-smbios'/>
      <qemu:arg value='file=/root/thin/smbios_type_0.bin'/>
      <qemu:arg value='-smbios'/>
      <qemu:arg value='file=/root/thin/smbios_type_1.bin'/>
      <qemu:arg value='-smbios'/>
      <qemu:arg value='file=/root/thin/smbios_type_2.bin'/>
      <qemu:arg value='-smbios'/>
      <qemu:arg value='file=/root/thin/smbios_type_3.bin'/>
      <qemu:arg value='-smbios'/>
      <qemu:arg value='file=/root/thin/smbios_type_11.bin'/>
    </qemu:commandline>

This doesn't make automatic activation work from host to vm, but at
least hardcodes the VM UUIDs and BIOS names, so you won't have to
re-activate in case of VM recreation.

After this you can go ahead with your Windows installation.

## After installation

Wait for windows to get the NVidia drivers and switch your monitor to
nice resolution.  If you are using a desktop NVidia graphics card, you
will have to add this to your VMs libvirt XML (`virsh edit vmname`):

    <features>
      <hyperv>
        ...
        <vendor_id state='on' value='1234567890ab/>
        ...
      </hyperv>
      ...
      <kvm><hidden state='on'/></kvm>
    </features>

This hides the fact of virtualization from the NVidia driver running in Windows.

Also, while the Windows setup only sees IDE CD-ROMs, it looks like,
the installed Windows only sees SCSI CD-ROMs, so you might have to
switch your drives over to the VirtSCSI bus using `virsh edit` or
`virt-manager` if you prefer graphical tools.

## Networking Bridge

Very easy and performant solution for home desktops, when the machine
is connected with wire to Ethernet.

## Networking NAT

Only solution that is compatible with Wifi.

## Audio

Virtualized audio (that is passed to pulseaudio over unix socket or
TCP) IS SHIT currently in QEMU/KVM.  Very stuttery, some latency, not
fixable.

People know about it, they are trying to patch it, they say it's hard.

Also, not too much work is going into, because there are very easy and
good workarounds.

Use one of these:

  - pass in your PCI audio if you don't need it on the host,
  - pass in a USB speaker or a USB sound card ($3 on alibaba),
  - use HDMI audio for the guest (no microphone though!)
  - use https://github.com/duncanthrax/scream .

I personally do solution 2+3 on one of my machines and solution 4 on the
other.

In case of solution 3, you have to regedit the Windows and enable MSI interrupts.
(https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#Slowed_down_audio_pumped_through_HDMI_on_the_video_card)

## Input (USB passthrough or EVDEV)

How to do input?

In case of multi-head or desktop on server: easy, just pass in a USB
PCI card or individual USB devices.

In case of a gaming virtual machine, this option is not so good: you
don't want two keyboards and mouses on your desk.

There are 3 ways to do better:

 - Input virtualization (quite complicated with PCI video passthrough),
 - Some GNU/Linux+Windows input sharing solution (I don't use any of
   them, but heard they are good),
 - EVDEV.

EVDEV is a little bit undocumented (e.g. no mention of it in the very
good ArchLinux wiki), but I use it on my gaming setup and it works
very well, after the difficult initial setup.

You just have to do this:

    <qemu:arg value='-object'/>
    <qemu:arg value='input-linux,id=mouse1,evdev=/dev/input/by-id/MY_MOUSE-event-mouse'/>
    <qemu:arg value='-object'/>
    <qemu:arg value='input-linux,id=kbd1,evdev=/dev/input/by-id/MY_KEYBOARD-event-kbd,grab_all=on,repeat=on'/>

Then when the VM starts, QEMU takes your input devices (X11 mouse will
not work, keyboard will not type), but if you press the two controls
(left and right) together, they are released back to your real desktop.

If you want to grab again, just press the control keys again.

Gotcha: AppArmor, either turn it off or don't forget to check your
kernel logs or syslog for AppArmor errors!

I also wrote some scripts on the X11 side and on windows side which
puts my display into DPMS sleep and then it tries the other inputs, so
I can switch without using the horrible menu of the display.

## Only thing left to do is some optimizations

Read it on the wiki or look into my full example around `cputune` and
`hugepages`.

## Other ideas that I didn't do

I don't care too much about IO latency.

If you do, you can:

  - pass in a separate SATA SSD whole disk,
  - buy a PCIe SSD card and pass it in on the PCI level.

For better CPU tuning, you can try the cpu isolation capabilities of
Linux, if I understand it correctly, you can completely disable some
cores on the host, instead of just pinning your VM to some cores.

# Complete example

See [libvirt-example.xml](libvirt-example.xml)!

This is from my home machine, where I use:
  - BIOS ID hacks,
  - EVDEV for mouse/keyboard input,
  - scream for audio output, no microphone,
  - no NVidia hacking, because I have a Quadro card.
