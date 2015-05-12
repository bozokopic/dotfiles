from libqtile.config import (Group, Key, Click, Drag, Screen, Match)
from libqtile.command import lazy
from libqtile import (layout, bar, widget, hook)
import libqtile
import libqtile.widget.launchbar
import subprocess
import os.path
import itertools
import functools
import contextlib


screens_count = str(
        subprocess.Popen(
            ['xrandr'],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE).communicate()[0]
    ).count(" connected ")


touchpad_id = None
with contextlib.suppress(Exception):
    result = subprocess.run(['xinput'], capture_output=True)
    stdout = result.stdout.decode('utf-8')
    for i in stdout.split('\n'):
        if 'TouchPad' in i:
            touchpad_id = int(i.split('id=')[1].split('[')[0].strip())


wlan_dev = None
with contextlib.suppress(Exception):
    result = subprocess.run(['ip', 'l'], capture_output=True)
    stdout = result.stdout.decode('utf-8')
    for i in stdout.split('\n'):
        if not i or i[0] in (' ', '\t'):
            continue
        temp_wlan_dev = i.split(':')[1].strip()
        if temp_wlan_dev and temp_wlan_dev[0] == 'w':
            wlan_dev = temp_wlan_dev
            break


mod = 'mod4'


groups = [
    Group('1', screen_affinity=0),
    Group('2', screen_affinity=0),
    Group('3', screen_affinity=0),
    Group('4', screen_affinity=0),
    Group('a', screen_affinity=1 % screens_count),
    Group('s', screen_affinity=1 % screens_count),
    Group('d', screen_affinity=1 % screens_count),
    Group('f', screen_affinity=1 % screens_count),
    # Group('z', screen_affinity=2),
    # Group('x', screen_affinity=2),
    # Group('c', screen_affinity=2),
    # Group('v', screen_affinity=2),
    Group('term', layout='max',
          matches=[Match(wm_instance_class=['tmux_term'])])
]


bar_background = ['#000000', '#000000', '#333333']


def get_icon_path(name):
    return os.path.expanduser('~/.dotfiles/pictures/icons/' + name + '.png')


def create_launch_bar():
    return libqtile.widget.launchbar.LaunchBar([
        (get_icon_path('chromium'), 'chromium'),
        (get_icon_path('falkon'), 'falkon'),
        (get_icon_path('qutebrowser'), 'qutebrowser'),
        (get_icon_path('dolphin'), 'dolphin'),
        (get_icon_path('atom'), 'atom'),
        (get_icon_path('claws-mail'), 'claws-mail'),
        (get_icon_path('kmix'), 'pavucontrol'),
        (get_icon_path('network'), 'connman-gtk'),
        (get_icon_path('keepassxc'), 'keepassxc'),
        (get_icon_path('clementine'), 'clementine'),
    ], pading=5)


def create_top_bar(screen_index):
    return bar.Bar([
        widget.CurrentLayoutIcon(scale=0.7),
        widget.CurrentLayout(),
        widget.Sep(),
        widget.WindowName(),
        widget.Prompt(name='prompt' + str(screen_index)),
        widget.Sep(),
        widget.TextBox('Cpu:'),
        widget.CPUGraph(),
        widget.Sep(),
        widget.TextBox('Memory:'),
        widget.MemoryGraph(),
        widget.Sep(),
        widget.TextBox('Net:'),
        widget.NetGraph(),
        widget.Sep(),
        widget.TextBox('Wlan:'),
        widget.Wlan(interface=wlan_dev),
        widget.Sep(),
        widget.TextBox('Battery:'),
        widget.Battery(),
        widget.Sep(),
        widget.TextBox('Volume:'),
        widget.Volume(),
        widget.Sep(),
        widget.Clock(format='%Y-%m-%d %H:%M:%S')
    ], 30, background=bar_background)


def create_bottom_bar(screen_index):
    return bar.Bar([
        widget.GroupBox(disable_drag=True,
                        fontsize=22,
                        visible_groups={g.name for g in groups
                                        if g.screen_affinity is None
                                        or g.screen_affinity == screen_index}),
        widget.Sep(),
        create_launch_bar(),
        widget.Sep(),
        widget.TaskList(fontsize=20)
    ] + ([widget.Systray(icon_size=35)] if screen_index == 0 else []), 35,
    background=list(reversed(bar_background)))


def create_screen(screen_index):
    return Screen(
        top=create_top_bar(screen_index),
        bottom=create_bottom_bar(screen_index))


screens = [create_screen(i) for i in range(screens_count)]


layouts = [
    layout.MonadTall(),
    layout.MonadWide(),
    layout.Max(),
    layout.VerticalTile(),
    layout.Zoomy()
]


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


def act_focus_group(group, qtile):
    qtile.groups_map[group.name].cmd_toscreen(group.screen_affinity)
    qtile.cmd_to_screen(group.screen_affinity)


def act_move_to_group(group, qtile):
    qtile.current_window.cmd_togroup(group.name)


def act_F12(qtile):
    if qtile.current_group.name != 'term':
        for screen in qtile.cmd_screens():
            if screen['group'] == 'term':
                qtile.cmd_to_screen(screen['index'])
                return
    qtile.current_screen.cmd_togglegroup('term')
    if qtile.current_group.name == 'term' and not qtile.current_group.windows:
        subprocess.Popen(['alacritty', '-e', 'tmux', 'new-session', '-A',
                          '-s', 'default'])


def act_enable_touchpad(qtile):
    subprocess.Popen(['xinput', 'enable', str(touchpad_id)])


def act_disable_touchpad(qtile):
    subprocess.Popen(['xinput', 'disable', str(touchpad_id)])


def act_left(qtile):
    lay = qtile.current_group.layout
    scr = qtile.current_screen
    scr_next = qtile.screens[(scr.index + 1) % len(qtile.screens)]
    change_screen = False
    if isinstance(lay, layout.Max):
        change_screen = True
    elif isinstance(lay, layout.MonadTall):
        try:
            lay.cmd_left()
        except ValueError:
            change_screen = True
    else:
        lay.cmd_previous()
    if change_screen:
        qtile.cmd_to_screen(scr_next.index)


def act_right(qtile):
    lay = qtile.current_group.layout
    scr = qtile.current_screen
    scr_next = qtile.screens[(scr.index + 1) % len(qtile.screens)]
    change_screen = False
    if isinstance(lay, layout.Max):
        change_screen = True
    elif isinstance(lay, layout.MonadTall):
        try:
            lay.cmd_right()
        except ValueError:
            change_screen = True
    else:
        lay.cmd_next()
    if change_screen:
        qtile.cmd_to_screen(scr_next.index)


def act_up(qtile):
    qtile.current_group.layout.cmd_up()


def act_down(qtile):
    qtile.current_group.layout.cmd_down()


def act_move_left(qtile):
    qtile.current_group.layout.cmd_swap_left()


def act_move_right(qtile):
    qtile.current_group.layout.cmd_swap_right()


def act_move_up(qtile):
    qtile.current_group.layout.cmd_move_up()


def act_move_down(qtile):
    qtile.current_group.layout.cmd_move_down()


def act_spawncmd(qtile):
    qtile.cmd_spawncmd(widget='prompt' + str(qtile.current_screen.index))


keys = list(itertools.chain(
    [Key([mod, 'shift'], 'q', lazy.window.kill()),
     Key([mod], 'w', lazy.next_layout()),
     Key([mod, 'shift'], 'e', lazy.shutdown()),
     Key([mod, 'shift'], 'r', lazy.restart()),

     Key([mod], 'Return', lazy.spawn('urxvt')),
     Key([mod], 'space', lazy.function(act_spawncmd)),


     Key([mod], 'Tab', lazy.layout.next()),
     Key([mod, 'shift'], 'space', lazy.window.toggle_floating()),
     Key([mod, 'shift'], 'Return', lazy.window.toggle_fullscreen()),

     Key([mod], 'h', lazy.function(act_left)),
     Key([mod], 'l', lazy.function(act_right)),
     Key([mod], 'j', lazy.function(act_down)),
     Key([mod], 'k', lazy.function(act_up)),
     Key([mod, 'shift'], "h", lazy.function(act_move_left)),
     Key([mod, 'shift'], "l", lazy.function(act_move_right)),
     Key([mod, 'shift'], "j", lazy.function(act_move_down)),
     Key([mod, 'shift'], "k", lazy.function(act_move_up)),
     Key([mod], "m", lazy.layout.grow()),
     Key([mod], "n", lazy.layout.shrink()),
     Key([mod, 'shift'], "m", lazy.layout.maximize()),
     Key([mod, 'shift'], "n", lazy.layout.normalize()),


     Key([], 'F12', lazy.function(act_F12)),
     # Key([], 'PrintScreen', lazy.spawn('spectacle')),


     Key([mod], 't', lazy.function(act_enable_touchpad)),
     Key([mod, 'shift'], 't', lazy.function(act_disable_touchpad)),
     ],


    [Key([mod], group.name,
         lazy.function(functools.partial(act_focus_group, group)))
     for group in groups if group.name != 'term'],

    [Key([mod, 'shift'], group.name,
         lazy.function(functools.partial(act_move_to_group, group)))
     for group in groups if group.name != 'term'],

))


@hook.subscribe.current_screen_change
def hook_current_screen_change():
    change_border_focus()


@hook.subscribe.setgroup
def hook_setgroup():
    change_border_focus()


def change_border_focus():
    qtile = hook.qtile
    for i in qtile.screens:
        if qtile.current_screen == i:
            if isinstance(i.group.layout, layout.MonadTall):
                if i.group.layout.border_focus != "#ff0000":
                    i.group.layout.border_focus = "#ff0000"
                    i.group.layout_all()
        else:
            if isinstance(i.group.layout, layout.MonadTall):
                if i.group.layout.border_focus != "#000000":
                    i.group.layout.border_focus = "#000000"
                    i.group.layout_all()


@hook.subscribe.startup
def hook_startup():
    qtile = hook.qtile
    screens_set = set()
    for g in groups:
        if g.screen_affinity is not None and g.screen_affinity not in screens_set:
            qtile.groups_map[g.name].cmd_toscreen(g.screen_affinity)
            screens_set.add(g.screen_affinity)
    with contextlib.suppress(Exception):
        subprocess.Popen(['feh', '--bg-scale',
                          os.path.expanduser('~/.dotfiles/pictures/bg1.jpg'),
                          os.path.expanduser('~/.dotfiles/pictures/bg2.jpg')])


@hook.subscribe.startup_once
def hook_startup_once():
    #with contextlib.suppress(Exception):
    #    subprocess.Popen(['dropbox'])
    #with contextlib.suppress(Exception):
    #    subprocess.Popen(['megasync'])
    with contextlib.suppress(Exception):
        subprocess.Popen(['kuiserver5'])


@hook.subscribe.client_new
def float_modal(window):
    if 383 in window.window.get_property('_NET_WM_STATE', unpack=int):
        window.floating = True
