#!/bin/sh
# List of AVDs:
# $ emulator -list-avds
# Start the emulator without SELinux:
# $ emulator -avd Android_API_29 -selinux permissive
# Related links:
# https://download.chainfire.eu/supersu/
# http://4pda.ru/forum/index.php?showtopic=318487

set -e -x

BIN_DIR="/system/xbin"
SU_ARC="SR5-SuperSU-v2.82-SR5-20171001224502.zip"
SU_APK="SuperSU-v2.82-SR5.apk"

ARCH=$(adb shell getprop ro.product.cpu.abi | tr -d '\n\r')
case "$ARCH" in
arm64|aarch64)
  ARCH="arm64"
;;
arm*)
  ARCH="arm"
;;
x86_64|amd64)
  ARCH="x64"
;;
i[3-6]86|x86)
  ARCH="x86"
;;
esac

adb root
adb shell "grep -q $BIN_DIR /proc/mounts || mount -t tmpfs -o size=50M tmpfs $BIN_DIR"

[ -e "/tmp/su" ] || mkdir -p /tmp/su
unzip -o "$SU_ARC" -d /tmp/su >/dev/null
if [ -e "/tmp/su/$ARCH/su.pie" ]
then
  mv /tmp/su/$ARCH/su.pie /tmp/su/$ARCH/su
fi
adb push /tmp/su/$ARCH/* $BIN_DIR
adb shell "$BIN_DIR/su --daemon&"
adb install "$SU_APK"

exit 0
