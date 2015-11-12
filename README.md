# Collection of various configuration files used across my machines.

## General (Linux + OS X)
 * vim config
 * tmux config
 * aliases (aliases.sh)

## Arch Linux specific
 * GUI & Eye candy
   * openbox: window manager
     * obconf
     * lxappearance
     * lxappearance-obconf
   * compton-git [aur]: composite manager (config: `~/.config/compton.conf`)
   * tint2: taskbar, systray (config: `~/.config/tint2/tint2rc`)
 * rxvt-unicode (urxvt): terminal
 * `~/.Xresources`
   * `rxvt-unicode` configurations
   * terminal colors.


## Folders
### `resources`
Mainly contains assets for eye candy (window decoration, etc.)
#### ArchNumix themes (variant of the [Numix theme](https://numixproject.org/))
These should be un-tar'd and installed to `/usr/share/themes`
 * ArchNumixDark: Numix with Arch blue and dark-grey
 * ArchNumixLight: like ArchNumixDark but with light titlebar
 * ArchNumixChromium: like ArchNumixDark but adapted to fit the style of chromium
 * ArchNumixWeb: uses exactly the same colours as the Arch website
 * ArchNumixWebChromium:  like ArchNumixWeb but adapted to fit the style of chromium
 * ArchNumixOSXLight: adapted to look like OSX Yosemite (the one used in the screenshots)
 * ArchNumixOSXDark: like ArchNumixOSXLight but with dark titlebar
 * ArchNumixWhite: looks a bit like Windows but has dark menus

### `zsh`
Custom zsh scripts

## Things that are not included in this repo
 * `flattr` icons: https://github.com/NitruxSA/flattr-icons  
      Installed via `flattr-icon-theme` package
