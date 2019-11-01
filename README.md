# avd-root

Get root permissions in Android Virtual Devices.

## Usage

Find out the name of AVD:

```sh
emulator -list-avds
```

Start the emulator with the name of AVD:

```sh
emulator -avd "AVD_NAME_HERE" -selinux permissive
```

After starting AVD run the script:

```sh
./avd-root.sh
```
