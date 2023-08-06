# LibreWolf

LibreWolf is a free and open source web browser descended from the
Mozilla Application Suite. It is small, fast and easy to use, and offers
many advanced features:

## Features:

* Popup Blocking
* Tabbed Browsing
* Live Bookmarks (ie. RSS)
* Extensions
* Themes
* FastFind
* Improved Security

librewolf.net

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/LibreWolf_icon.svg/480px-LibreWolf_icon.svg.png?20220122014936" alt="librewolf logo" width="40%" height="auto">

## How to use this Makejail

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/librewolf

OPTION mount_devfs
OPTION devfs_ruleset=12
OPTION copydir=files
OPTION file=/etc/rc.conf
OPTION x11
```

Where `options/network.makejail` are the options that suit your environment, for example:

```
ARG network
ARG interface=librewolf

OPTION virtualnet=${network}:${interface} default
OPTION nat
```

A generic ruleset that allows LibreWolf to run smoothly is as follows:

```
[devfsrules_librewolf=12]
add include $devfsrules_hide_all
add include $devfsrules_unhide_basic
add include $devfsrules_unhide_login

# I/O sound devices
add path 'sndstat' unhide

# USB (e.g.: webcam)
add path 'usb' unhide
add path 'usb/*' unhide

# 3D support
add path 'dri' unhide
add path 'dri/*' unhide
add path 'drm' unhide
add path 'drm/*' unhide
add path 'pci' unhide

# webcam
add path 'cuse*' unhide
add path 'video*' unhide

# soundcard
add path 'mixer*' unhide
add path 'dsp*' unhide
```

If you want to limit what the `librewolf` jail can do, comment all you want.

The tree structure of the `files/` directory is as follows:

```
# tree -pug files/
[drwxr-xr-x root     wheel   ]  files/
└── [drwxr-xr-x root     wheel   ]  etc
    └── [-rw-r--r-- root     wheel   ]  rc.conf

1 directory, 1 file
```

Where `rc.conf` is your custom `rc.conf(5)` file, for example:

```
clear_tmp_X="NO"
```

The `rc.conf(5)` file above sets `clear_tmp_X` to `NO` to not remove the sockets and various related files before the jail starts.

Open a shell and run `appjail makejail` and `appjail start`:

```sh
appjail makejail -j librewolf -- --network development
appjail start librewolf
```

After Makejail builds the jail, you can run LibreWolf using the `librewolf_open` custom stage:

```sh
appjail run -s librewolf_open librewolf
# or to open a specific website:
appjail run -s librewolf_open -p url=http://example.org librewolf
```

### Arguments

* `librewolf_tag` (default: `13.2-full`): see [#tags](#tags).

## How to build the Image

Make any changes you want to your image.

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/librewolf --file build.makejail
```

Build the jail:

```sh
appjail makejail -j librewolf -- \
    --librewolf_enable_webcamd 1
```

Remove unportable or unnecessary files and directories and export the jail:

```sh
appjail stop librewolf
appjail cmd local librewolf sh -c "rm -f var/log/*"
appjail cmd local librewolf sh -c "rm -f var/cache/pkg/*"
appjail cmd local librewolf sh -c "rm -f var/run/*"
appjail cmd local librewolf vi etc/rc.conf
appjail image export librewolf
```

### Arguments

* `librewolf_enable_3d` (default: `1`): Install with `graphics/mesa-dri` and add the `librewolf` user to the `video` group.
* `librewolf_enable_webcamd` (default: `0`): Create a group named `webcamd` (GID: `145`) and add the `librewolf` user to it.

## Recommendation

1.- Use hardware acceleration when available.

<p align="center">
    <img src="https://i.imgur.com/7FHrTsB.png" />
</p>

2.- Enable WebRender.

<p align="center">
    <img src="https://i.imgur.com/1kZCy3f.png" />
</p>

## Tags

| Tag         | Arch    | Version           | Type   | `librewolf_enable_3d` | `librewolf_enable_webcamd` |
| ----------- | ------- | ----------------- | ------ | --------------------- | -------------------------- |
| `13.2-full` | `amd64` | `13.2-RELEASE-p2` | `thin` |           1           |              1             |
