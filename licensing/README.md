# Windows 10 licensing

UPADTE (2020-06-27): most of the information below is still correct,
but I also made a more detailed investigation and summary on the
practicalities of cheap "ebay" licenses:
[license-types-and-ebay.md](license-types-and-ebay.md)

Windows 10 is free to download, but after 1-3 months of usage, you have
to get a license and prove it to Microsoft servers over the internet.
This process is called activation.

How to download Windows 10 ISO for installation:

  - Google for "Media Creation Tool" if you already have a working windows,
  - Direct download: https://www.microsoft.com/en-us/software-download/windows10ISO,

You can use these ISO files for installation.  If you want to use a
pendrive, use `isohybrid` on the downloaded ISO and then `dd` it to
`/dev/sdx`.

For installation, you can just skip the part when it asks for your key
to get your trial/grace period.  If in some situation you are forced
to enter a product key (upgrades, special cases, whatever), you can
try to use the so called "generic product keys" which you can Google
for (it's legit, Microsoft created them for these situations).

## What is activation?

Every working computer is different in some way: hardware
configurations can be very-very different between machines (PCI bus
device IDs, vendor+product IDs, UUID of motherboard, BIOS revision,
etc.).

So MS basically has a hash function from the set of existing
computers to some big-enough set (I guess 2^128 or 2^256).

When you start activation, they compute the hash and send the
following packet to the activation servers: `(H(product_key),
H(hardware))`.

MS server stores a big database of these tuples and it has the
following rules:

  - if `H(product_key)` is not found, then activation is valid and the
    tuple is saved,

  - if `H(product_key)` is found, but `H(hardware)` is different, then
    the activation is shady and they either reject it or they allow a
    couple of number of reactivations (2-3).  If they accept it, they
    save the new `H(hardware)`,

  - if they have rejected you in the previous point, you can just call
    in and they will allow it in exchange for wasting 10 mins of your
    time.  The phoneline is fully automated, no human interaction
    needed.  You have to promise, that you are only using your OEM
    license on one computer.

If the activation works based on only the second paragraph, then it
will say that "Windows is activated with a digital license".  Which
basically means, that for this `H(product_key)`, the `H(hardware)` is
stored on MS servers.

## Cheap versions of licenses, keep away if you can

N/KN editions: the N and KN editions are european/korean court ordered
versions with removed multimedia apps and so.  You better aviod these
editions, just unnecessary complication.  The licensing is different,
so if you somehow have a license for this, you have to install this
version and then you can install the missing apps/codecs/apis from
Microsoft for free.  (Media Feature Pack for N and KN versions::
https://www.microsoft.com/en-us/download/details.aspx?id=48231)

Single Language: special edition of Home, where it is not allowed to
change the system language after installation is finished.  So there
are no separate language licenses, you can still install english with
a German single language iso, but you have to reinstall, you can't
just change die Sprache.

## OEM

OEM: an edition, where Microsoft's opinion is that you are not allowed
to move the license to another computer once installed.  It's not
about experts or companies preinstalling your computer, you are
perfectly allowed to buy OEM licenses (called System Builder), but you
can only install it to one hardware.  The Court of Justice of Europen
Union decided on 2012-07-03 in the UsedSoft vs Oracle case that
selling OEM software is legit (provided you delete the original
software before selling it).  It's also legal to export these licenses
out of the EU.

Based on this decision there is now a big market on ebay.de, where you
can basically buy Home/Pro licenses for <$5.

Most of these have to be phone activated (Microsoft doesn't like you
of course, so they make it hard), but this process takes <10 minutes,
can be done for free by calling the US number from hangouts and
doesn't involve talking to humans or pleading your case, it's a fully
automated robot.  After phone activating a hardware once, later
reinstallations on the same hardware don't require phone activation.

If you want to obey to the OEM rules, you can buy from the US/UK shops
which really deliver to you (CD/DVD+sticker) and according to the
rules, you can pick-up a laptop in Los Angeles for 5 days.  These
laptops are non-functional and they will be discarded if you don't
pick them up.  These licenses cost ~$20 + shipping (which makes them
expensive).

US story: ebay shop with windows licenses and 1-2 hard drives.

## Retail: the real deal

Retail: edition that you can buy in shops from the shelves.  Very-very
expensive (~280 CHF for Pro), but gives you the right to do whatever
you want with the stuff, reinstall as many times you want on as many
different computers you want, provided that you only have one system
installed at a time.

## Windows 7, 8 and 8.1 free upgrades

Anyone who has a previous product key, can upgrade one machine to the
same edition (e.g. Windows 7 Home to Windows 10 Home).  Officially
this ended 2 years ago, in practice this has not ended and I don't
think it will.

How is it implemented though?

When you first activate a Windows 10 with an old product key, then
Windows will store the `H(hardware)` for a `H(generic_key)`, not your
`H(product_key)`.  These generic keys have the special property, that
they can be in the database many times without rejection, but in case
of rejection, you can't phone activate.  So the only way to get into
the DB is with an old license key.

Officially, these free upgrades are only valid until the end of your
machine's lifecycle, but there are two exceptions:

  - you can tie this license to your MS account and then you can make
    bigger hardware changes to your system and it's not clear what is
    a bigger hardware change exactly,

  - you can declare on the old machine, that you don't like the
    upgrade and you go back to windows 7, and then you move your
    windows 7 license, then you upgrade again on the new machine.

## Virtual Machines

The license allows to run Windows inside VMs, but because the emulated
hardware is very peculiar, it's not known if it's possible to match
the `H(hardware)` of a previous real installation.

Therefore, in the worst case you will have to phone activate after the
real machine to virtual move.  This will also make it impossible to
keep the real installation and use both.  This is disallowed by the
license agreement anyways.

It's well advised to keep your VM identity controlled, so you don't
have to phone MS on every reinstallation, so make sure you have
control over your VM's BIOS strings and UUIDs.

## Practicalities
### I have a product key, but I have no idea what is it!

Use https://github.com/Superfly-Inc/ShowKeyPlus/releases

### How to test my digital license?

After phone activation Windows will say "Windows 10 is activated", but
you can't be sure that your `H(hardware)` is saved and therefore it
will work 2 years from now, when you want to reinstall.

Go to Settings, Activation; then change the product key to the generic
product key of your edition.  This will deactivate Windows, reboot.
When reboot has finished, enter your real product key.  After it
finishes it will say the correct "Windows 10 is activated with a
digital license" string.

### How to buy a cheap OEM license?

I used them: https://www.ebay.de/usr/lizenzking, it was 4 EUR.  I had
to wait 15 minutes for the code.

They look more popular and they are cheaper:
https://www.ebay.de/usr/svemars0 .  They promise sending in 30 seconds.

### Home -> Pro Upgrades, flight mode trick

OK, so now you learned that you can get a Pro license for 4 EUR, this
means that you definitely want to upgrade your Windows Home laptop for
4 EUR and use BitLocker instead of the problematic VeraCrypt solution.

The problem is, that if you enter this cheap OEM code to the edition
upgrade UI of Windows 10, then it will reject it, because it's an OEM
code, so it's an impossible scenario, that you want to upgrade.

Solution: enter the generic product key and wait for the upgrade, then
after reboot enter your specific product key for activation.

There is a protection for stupid users: upgrade is not accepted if
activation is invalid, this is because if you upgrade from Home to
Pro, it's impossible to downgrade, you need full reinstall.  With the
generic product keys, activation is invalid.

Solution: put your laptop into flight mode and enter the generic
product key.  Bring out your laptop from flight mode only after the
upgrade has finished.  The upgrade is really fast, takes one reboot
and ~5 minutes.  No installed programs or data was hurt.

Once the upgrade has finished (using a new 4 EUR code), you can use
the original Home license in e.g. a virtual machine, where disk
encryption is not needed.

## Automatic product key from BIOS

Newer laptops which were presold with Windows will have a key embedded
in the BIOS which is automatically used in a reinstall.

Under Linux you can dump these keys from `/sys/firmware/acpi/tables`.
It's in either the MSDM or in the SLIC table.

This is problematic, if you used that key for something else and you
instead want to use another key.  You could of course enter a new key
after first boot in the Activation setting, but there is one peculiar
scenario: you have Pro embedded in BIOS, but you want to install Home.

Solution: you have to create a special installation USB media, details:
https://superuser.com/questions/1020961/prevent-windows-10-installer-from-using-the-preinstalled-serial-key-without-disa
