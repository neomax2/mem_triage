#!/bin/bash
mkdir $1.rekall.maldump
mkdir $1.rekall.regdump
plugins=(pslist desktops sessions threads dlllist handles filescan netscan arp dns_cache connections connscan sockets ldrmodules psxview modscan services svcscan hooks_inline hooks_eat hooks_iat ssdt driverirp object_tree userassist hives)
for ndx in "${plugins[@]}"; do
	rekall -f $1 $ndx --output $1.$ndx.rekall.txt &
done

rekall -f $1 regdump -D $1.rekall.regdump --output $1.rekall.regdump.txt &
rekall -f $1 malfind --dump_dir=$1.rekall.maldump --output $1.malfind.rekall.txt &
wait
