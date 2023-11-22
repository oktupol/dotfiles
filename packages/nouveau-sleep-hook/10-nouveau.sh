#!/bin/bash

case $1/$2 in
	pre/*)
		echo "Disabling nouveau kernel module prior to sleep"
		/usr/bin/echo "0" > /sys/class/vtconsole/vtcon1/bind
		/usr/bin/rmmod nouveau
		;;
	post/*)
		echo "Enabling nouveau kernel module post sleep"
		/usr/bin/modprobe nouveau
		/usr/bin/echo "1" > /sys/class/vtconsole/vtcon1/bind
		;;
esac
