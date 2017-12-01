#!/usr/bin/env python3

# This script listens for i3 events and updates workspace names to show icons
# for running programs.  It contains icons for a few programs, but more can
# easily be added by adding them to WINDOW_ICONS below.
#
# It also re-numbers workspaces in ascending order with one skipped number
# between monitors (leaving a gap for a new workspace to be created). By
# default, i3 workspace numbers are sticky, so they quickly get out of order.
#
# Dependencies
# * xorg-xprop  - install through system package manager
# * i3ipc       - install with pip
# * fontawesome - install with pip
#
# Installation:
# * Download this script and place it in ~/.config/i3/ (or anywhere you want)
# * Add "exec_always ~/.config/i3/i3-autoname-workspaces.py &" to your i3 config
# * Restart i3: $ i3-msg restart
#
# Configuration:
# The default i3 config's keybindings reference workspaces by name, which is an
# issue when using this script because the "names" are constantaly changing to
# include window icons.  Instead, you'll need to change the keybindings to
# reference workspaces by number.  Change lines like:
#   bindsym $mod+1 workspace 1
# To:
#   bindsym $mod+1 workspace number 1

import i3ipc
import logging
import signal
import sys
import fontawesome as fa

from util import *

# Add icons here for common programs you use.  The keys are the X window class
# (WM_CLASS) names (lower-cased) and the icons can be any text you want to
# display.
#
# Most of these are character codes for font awesome:
#   http://fortawesome.github.io/Font-Awesome/icons/
#
# If you're not sure what the WM_CLASS is for your application, you can use
# xprop (https://linux.die.net/man/1/xprop). Run `xprop | grep WM_CLASS`
# then click on the application you want to inspect.
WINDOW_ICONS = {
    'atom': fa.icons['code'],
    'cura': fa.icons['cube'],
    'darktable': fa.icons['picture-o'],
    'evince': fa.icons['file-pdf-o'],
    'feh': fa.icons['picture-o'],
    'firefox': fa.icons['firefox'],
    'google-chrome': fa.icons['chrome'],
    'gpick': fa.icons['eyedropper'],
    'kicad': fa.icons['microchip'],
    'libreoffice': fa.icons['file-text-o'],
    'mupdf': fa.icons['file-pdf-o'],
    'spotify': fa.icons['music'],  # could also use the 'spotify' icon
    'steam': fa.icons['steam'],
    'subl': fa.icons['file-text-o'],
    'subl3': fa.icons['file-text-o'],
    'thunar': fa.icons['files-o'],
    'urxvt': fa.icons['terminal'],
    'xfce4-terminal': fa.icons['terminal'],
    'zenity': fa.icons['window-maximize'],
    'slack': fa.icons['slack'],
    'pcmanfm': fa.icons['folder'],
    'nemo': fa.icons['folder'],
    'mplayer': fa.icons['film'],
}

# This icon is used for any application not in the list above
DEFAULT_ICON = ''


def icon_for_window(window):
    # Try all window classes and use the first one we have an icon for
    classes = xprop(window.window, 'WM_CLASS')
    if classes != None and len(classes) > 0:
        for cls in classes:
            cls = cls.lower()  # case-insensitive matching
            if cls in WINDOW_ICONS:
                return WINDOW_ICONS[cls]
    logging.info(
        'No icon available for window with classes: %s' % str(classes))
    return DEFAULT_ICON


# renames all workspaces based on the windows present
# also renumbers them in ascending order, with one gap left between monitors
# for example: workspace numbering on two monitors: [1, 2, 3], [5, 6]
def rename_workspaces(i3, e=None):
    ws_infos = i3.get_workspaces()
    prev_output = None
    n = 1
    for ws_index, workspace in enumerate(i3.get_tree().workspaces()):
        ws_info = ws_infos[ws_index]
        # print(ws_info)

        # name_parts = parse_workspace_name(workspace.name)
        # name_parts['icons'] = ' '.join(
        #     [icon_for_window(w) for w in workspace.leaves()])
        # new_name = construct_workspace_name(name_parts)

        name_parts = {'num': str(n), 'shortname': None, 'icons': None}
        focused = i3.get_tree().find_focused()
        if workspace.id == focused.workspace().id:
            # This happens when the last window in a workspace just got closed
            if focused.window is None:
                new_name = '[%d]' % n
            else:
                icon = icon_for_window(focused)
                title = focused.name
                if len(title) > 40:
                    title = title[:40] + ' ...'
                new_name = '%d:[%s] %s' % (n, icon, title)
        else:
          new_name = '%d:[%d] ' % (n, n)
          new_name +='  '.join([icon_for_window(w) for w in workspace.leaves()])

        # As we enumerate, leave one gap in workspace numbers between each monitor.
        # This leaves a space to insert a new one later.
        if ws_info.output != prev_output and prev_output != None:
            n += 1
        prev_output = ws_info.output

        # renumber workspace
        name_parts['num'] = n
        n += 1

        # new_name = construct_workspace_name(name_parts)
        # if workspace.name == new_name:
            # continue
        # i3.command('rename workspace "%s" to "%s"' % (workspace.name, n-1))
        i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


# Rename workspaces to just numbers and shortnames, removing the icons.
def on_exit(i3):
    for workspace in i3.get_tree().workspaces():
        name_parts = parse_workspace_name(workspace.name)
        name_parts['icons'] = None
        new_name = construct_workspace_name(name_parts)
        if workspace.name == new_name:
            continue
        i3.command('rename workspace "%s" to "%s"' % (workspace.name,
                                                      new_name))
    i3.main_quit()
    sys.exit(0)


# Dynamically name workspaces after the current window class
def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    ws_name = "%s:%s" % (focused.workspace().num, focused.window_class)
    i3.command('rename workspace to "%s"' % ws_name)

    ws_infos = i3.get_workspaces()
    ws_idx = focused.workspace().num
    ws_info = ws_infos[ws_idx-1]
    workspace = i3.get_tree().workspaces()[ws_idx-1]

    name_parts = parse_workspace_name(workspace.name)
    name_parts['icons'] = ' '.join(
        [icon_for_window(w) for w in workspace.leaves()])
    focused = i3.get_tree().find_focused()
    name_parts['shortname'] = focused.window_class

    new_name = construct_workspace_name(name_parts)
    if workspace.name == new_name:
        return
    i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)

    i3 = i3ipc.Connection()

    # Exit gracefully when ctrl+c is pressed
    for sig in [signal.SIGINT, signal.SIGTERM]:
        signal.signal(sig, lambda signal, frame: on_exit(i3))

    rename_workspaces(i3, None)

    # Call rename_workspaces() for relevant window events
    def window_event_handler(i3, e):
        # All window events
        if e.change in ['new', 'close', 'move', 'focus', 'title',
            'floating', 'urgent', 'fullscreen_mode']:
            rename_workspaces(i3, e)

    def workspace_event_handler(i3, e):
        # The workspace just got created.
        old_name = e.current.name
        new_name = '[%d]' % e.current.num
        if e.change in ['init',]:
            i3.command('rename workspace "%s" to "%s"' % (old_name, new_name))

    i3.on('window', window_event_handler)
    i3.on('workspace', workspace_event_handler)
    # i3.on('window::focus', on_window_focus)
    i3.main()
