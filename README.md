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
xhost +
appjail run -s librewolf_open librewolf
# or to open a specific website:
appjail run -s librewolf_open -V URL=http://example.org librewolf
```

### Arguments

* `librewolf_tag` (default: `13.3-full`): see [#tags](#tags).
* `librewolf_sound_devices` (default: `1`): Enables `sndstat`, `mixer*` and `dsp*` devices.
* `librewolf_3d_devices` (default: `1`): Enables `dri`, `dri/*`, `drm`, `drm/*` and `pci` devices.
* `librewolf_webcam_devices` (default: `1`): Enables `cuse*`, `video*`, `usb` and `usb/*` devices.

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

| Tag         | Arch    | Version        | Type   | `librewolf_enable_3d` | `librewolf_enable_webcamd` |
| ----------- | ------- | -------------- | ------ | --------------------- | -------------------------- |
| `13.3-full` | `amd64` | `13.3-RELEASE` | `thin` |         `1`           |            `1`             |
| `14.0-full` | `amd64` | `14.0-RELEASE` | `thin` |         `1`           |            `1`             |
