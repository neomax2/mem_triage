#!/bin/bash
mkdir $1.vol.maldump
plugins=(pslist psscan pstree ldrmodules psxview modscan apihooks ssdt driverirp idt dlllist getsids handles filescan svcscan connections connscan sockets sockscan netscan hivelist shimcache userassist)
for ndx in "${plugins[@]}"; do
	vol.py -f $1 $ndx --output=text --output-file=$1.$ndx.vol.txt --profile=$2 &
done
vol.py -f $1 pstotal --output=dot --output-file=$1.pstotal.vol.dot --profile=$2 &
vol.py -f $1 malfind --dump-dir=$1.vol.maldump --output=text --output-file=$1.malfind.vol.txt --profile=$2 &
vol.py -f $1 timeliner --output-file=$1.timeliner.vol.csv --profile=$2 &
wait
