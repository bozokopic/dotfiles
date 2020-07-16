F12
    python ~/.config/sxhkd/terminal_i3.py

mod4 + Return
    alacritty
mod4 + space
    rofi -show drun
mod4 + backslash
    i3-msg "split h"
mod4 + minus
    i3-msg "split v"
mod4 + Tab
    i3-msg "layout toggle split"
mod4 + p
    i3-msg "focus parent"
mod4 + r
    i3-msg "mode resize"

mod4 + shift + r
    i3-msg "restart"
mod4 + shift + e
    i3-msg "exit"
mod4 + shift + q
    i3-msg "kill"
mod4 + shift + space
    i3-msg "floating toggle"
mod4 + shift + Return
    i3-msg "fullscreen toggle"

mod4 + {h, Left}
    i3-msg "focus left"
mod4 + {j, Down}
    i3-msg "focus down"
mod4 + {k, Up}
    i3-msg "focus up"
mod4 + {l, Right}
    i3-msg "focus right"

mod4 + shift + {h, Left}
    i3-msg "move left"
mod4 + shift + {j, Down}
    i3-msg "move down"
mod4 + shift + {k, Up}
    i3-msg "move up"
mod4 + shift + {l, Right}
    i3-msg "move right"
