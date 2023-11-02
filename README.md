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

Open a shell and run `appjail makejail` and `appjail start`:

```sh
appjail makejail -j librewolf -f gh+AppJail-makejails/librewolf \
    -o virtualnet=":<random> default" \
    -o nat \
    -o x11
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
* `librewolf_sound_devices` (default: `1`): Enables `sndstat`, `mixer*` and `dsp*` devices.
* `librewolf_3d_devices` (default: `1`): Enables `dri`, `dri/*`, `drm`, `drm/*` and `pci` devices.
* `librewolf_webcam_devices` (default: `1`): Enables `cuse*`, `video*`, `usb` and `usb/*` devices.

## How to build the Image

```sh
appjail makejail -j librewolf -f "gh+AppJail-makejails/librewolf --file build.makejail" \
    -o virtualnet=":<random> default" \
    -o nat \
        -- \
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
| `13.2-full` | `amd64` | `13.2-RELEASE-p4` | `thin` |           1           |              1             |
