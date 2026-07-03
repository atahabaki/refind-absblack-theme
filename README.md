# rEFInd absblack Theme

An absolute black theme for [The rEFInd Boot Manager](https://www.rodsbooks.com/refind/). Designed to be minimalist, clean, and ideal for OLED displays or anyone who prefers a stark, dark boot environment.

## Prerequisites

This repository contains the source files. To build the SVGs and install the theme, you will need:

- A working installation of **rEFInd**
- [Inkscape](https://inkscape.org) for exporting the SVG icons
- [nushell](https://nushell.sh) to run the build and install scripts

## Installation

The build and installation process is fully scripted with nushell.

> [!IMPORTANT]
> Installing a rEFInd theme requires write access to the EFI System Partition (ESP). Ensure that the ESP is mounted before running the installation commands. During installation, you may be prompted for your `sudo` password so the theme can be copied to your rEFInd installation.

```nu
use toolkit.nu
toolkit build
toolkit install
```

> [!NOTE]
> `toolkit install --simulate` performs a dry run of the installation process. It reports the actions that would be taken without modifying the EFI System Partition or installing the theme. It does **not** simulate or preview the rEFInd boot environment.

## Uninstall

To remove the theme, run:

```nu
use toolkit.nu
toolkit uninstall
```

## Trademark Notice

This project includes icons representing various operating systems. Linux distribution names and logos, Windows, macOS, and any other trademarks are the property of their respective trademark owners.

This project is not affiliated with, endorsed by, or sponsored by any of those organizations. The logos are used solely for identification purposes within the theme.
