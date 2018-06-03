#!/bin/bash

for i in 0 1 2 3 11 ; do
	( sudo dmidecode -t $i -u | grep $'^\t\t[^"]' | xargs -n1 | perl -lne 'printf "%c", hex($_)' ; echo -ne '\x00' ) > smbios_type_$i.bin
done
sudo cat /sys/firmware/acpi/tables/MSDM >MSDM
# maybe SLIC on a BIOS machine later!
