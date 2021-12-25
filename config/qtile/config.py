# QTile

from typing import List  # noqa: F401

from libqtile import qtile
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.hook import subscribe
from libqtile.command.client import InteractiveCommandClient 

mod = "mod4"
terminal = guess_terminal()

# To match the vim Badwolf theme
colors = [
    '#242321', # darkgravel
    '#8cffba', # saltwatertaffy
    '#45413b', # deepgravel
    '#f4cf86', # dirtyblonde
    '#aeee00', # lime
    '#141413', # blackestgravel
    '#ffa724', # orange
    '#141413'  # blackestgravel
]

workspaces = [
    {
        'key': "1",
        'name': "TRM",
        'layout': "columns",
        'matches': None
    },
    {
        'key': "2",
        'name': "WWW",
        'layout': "max",
        'matches': [
            Match(wm_class='Chromium')
        ]
    },
    {
        'key': "3",
        'name': "DEV",
        'layout': "max",
        'matches': [
            Match(wm_class='code-oss'), 
            Match(wm_class='Processing'),
            Match(wm_class='processing-app-ui-Splash')
        ]
    },
    {
        'key': "4",
        'name': "GFX",
        'layout': "max",
        'matches': [
            Match(wm_class='Aseprite')
        ]
    },
    {
        'key': "5",
        'name': "SCP",
        'layout': "floating",
        'matches': None
    }
]

groups = [Group(w['name'], layout=w['layout'], matches=w['matches']) for w in workspaces]

@subscribe.group_window_add
def focus_group(group, window):
    if group != qtile.current_group:
        for w in workspaces:
            if group.name == w['name']:
                qtile.cmd_simulate_keypress([mod], w['key'])

@lazy.function
def volume_up(qtile):
    qtile.cmd_spawn("pactl set-sink-volume @DEFAULT_SINK@ +1000")

@lazy.function
def volume_down(qtile):
    qtile.cmd_spawn("pactl set-sink-volume @DEFAULT_SINK@ -1000")

@lazy.function
def volume_mute(qtile):
    qtile.cmd_spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")

def open_pavucontrol():
    qtile.cmd_spawn("pavucontrol")

def open_powermenu():
    qtile.cmd_spawn("clearine")

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "space", lazy.layout.next()),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "space", lazy.layout.normalize()),

    # Toggle between different layouts
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    # Basic controls
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod, "shift"], "Return", lazy.spawncmd()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),

    # Sound controls
    Key([], "XF86AudioMute", volume_mute),
    Key([], "XF86AudioRaiseVolume", volume_up),
    Key([], "XF86AudioLowerVolume", volume_down),
]

for w in workspaces:
    keys.extend([
        Key([mod], w['key'], lazy.group[w['name']].toscreen()),
        Key([mod, "shift"], w['key'], lazy.window.togroup(w['name'], switch_group=True)),
    ])

layouts = [
    layout.Columns(border_focus=colors[6], border_width=4),
    layout.Bsp(border_focus=colors[6], border_width=4),
    layout.Max(),
    layout.Floating(),
    #layout.Matrix(),
    #layout.Stack(num_stacks=2),
    #layout.MonadTall(),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
]

widget_defaults = dict(
    font='Roboto Mono',
    fontsize=12,
    padding=0,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # Power CurrentLayout
                widget.CurrentLayout(
                    fmt=' {0:10s}',
                    background=colors[4],
                    foreground=colors[5]),
                widget.TextBox(
                    text='\uE0B0 ',
                    fontsize='15',
                    background=colors[0],
                    foreground=colors[4]),
                # GroupBox
                widget.GroupBox(
                    disable_drag=True,
                    highlight_method='text',
                    borderwidth=2,
                    this_current_screen_border=colors[3],
                    background=colors[0],
                    foreground=colors[1]),
                # Prompt
                widget.Prompt(
                    background=colors[0],
                    foreground=colors[1]),
                # Spacer
                widget.Spacer(
                    background=colors[0],
                    foreground=colors[1]),
                widget.Systray(
                    background=colors[0],
                    foreground=colors[1]),
                # Power Wlan 
                widget.TextBox(
                    text=' \uE0B2',
                    fontsize='15',
                    background=colors[0],
                    foreground=colors[2]),
                widget.Wlan(
                    interface='wlp3s0',
                    format=' {essid} {quality}/70',
                    background=colors[2],
                    foreground=colors[3]),
                # Power Battery 
                widget.TextBox(
                    text=' \uE0B2',
                    fontsize='15',
                    background=colors[2],
                    foreground=colors[4]),
                widget.TextBox(
                    text=' \u21AF ',
                    fontsize='15',
                    background=colors[4],
                    foreground=colors[5]),
                widget.Battery(
                    format='{char} {percent:2.0%}',
                    background=colors[4],
                    foreground=colors[5]),
                # Power Volume 
                widget.TextBox(
                    text=' \uE0B2',
                    fontsize='15',
                    background=colors[4],
                    foreground=colors[2]),
                widget.TextBox(
                    text=' \u266A ',
                    fontsize='15',
                    background=colors[2],
                    foreground=colors[3],
                    mouse_callbacks={'Button1': open_pavucontrol}),
                widget.PulseVolume(
                    background=colors[2],
                    foreground=colors[3]),
                # Power Clock 
                widget.TextBox(
                    text=' \uE0B2',
                    fontsize='15',
                    background=colors[2],
                    foreground=colors[4]),
                widget.Clock(
                    format=' %Y-%m-%d %a %I:%M %p',
                    background=colors[4],
                    foreground=colors[5]),
                # Power Logout 
                widget.TextBox(
                    text=' \uE0B2',
                    fontsize='15',
                    background=colors[4],
                    foreground=colors[6]),
                widget.TextBox(
                    text=' \u2718 ',
                    fontsize='15',
                    background=colors[6],
                    foreground=colors[7],
                    mouse_callbacks={'Button1': open_powermenu}),
            ],
            20,
        ),
    ),
]

mouse = [
    Drag([mod], "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2",
        lazy.window.bring_to_front())
]

floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='pavucontrol'),
    Match(wm_class='processing-app-ui-Splash'),
])

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True

wmname = "LG3D"
