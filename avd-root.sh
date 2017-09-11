#!/bin/bash -e
ARCH=$1
if [ "$#" -ne 1 ]
then
    echo "Usage: $0 <arm|x86>"
    exit 1
fi
adb root
adb push ./bb/$ARCH/busybox /data/local/busybox
adb shell "chmod 755 /data/local/busybox"
adb shell "/data/local/busybox mount -o rw,remount /system"
adb shell "/data/local/busybox --install -s /system/xbin"
adb shell "rm -r /system/media/audio"
adb push ./su/$ARCH/bin/su /system/bin/su
adb shell "chown 0:0 /system/bin/su"
adb shell "chmod 6755 /system/bin/su"
adb install ./su/$ARCH/app/Superuser.apk
exit 0
