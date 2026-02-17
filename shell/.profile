
prepend_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}

append_lua_path() {
    LUA_PATH="${LUA_PATH:+$LUA_PATH;}$1/?.lua;$1/?/init.lua"
    LUA_CPATH="${LUA_CPATH:+$LUA_CPATH;}$1/?.so"
}

[ -z "$XDG_RUNTIME_DIR" ] && \
    export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir 

[ ! -d "$XDG_RUNTIME_DIR" ] && \
    mkdir "$XDG_RUNTIME_DIR" && \
    chmod 0700 "$XDG_RUNTIME_DIR"

[ -z "$SSH_AUTH_SOCK" ] && \
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# export CHICKEN_INSTALL_REPOSITORY=~/.local/opt/chicken
# export GDK_BACKEND=wayland
# export LIBGL_ALWAYS_SOFTWARE=1
# export QT_AUTO_SCREEN_SCALE_FACTOR=1
# export QT_ENABLE_HIGHDPI_SCALING=1
# export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORMTHEME=kde
# export QT_WAYLAND_FORCE_DPI=120
# export SDL_VIDEODRIVER=wayland
# export SWEETHOME3D_JAVA3D=1.6
# export WLR_DRM_NO_MODIFIERS=1
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=qt6ct
export VISUAL=nvim

prepend_path ~/.local/opt/river/bin
prepend_path ~/.local/opt/janet/bin
prepend_path ~/.local/opt/chibi/bin
prepend_path ~/.local/opt/gambit/bin
prepend_path ~/.local/opt/chicken/bin
prepend_path ~/.local/opt/nnn/bin
prepend_path ~/.local/bin
export PATH

[ -n "$(command -v luarocks)" ] && \
    eval "$(luarocks path)"

append_lua_path ~/repos/private/bk-lua/src_lua
export LUA_PATH
export LUA_CPATH

# nix_profile_sh=~/.nix-profile/etc/profile.d/nix.sh
# [ -e $nix_profile_sh ] && . $nix_profile_sh
# export LOCALE_ARCHIVE=~/.nix-profile/lib/locale/locale-archive

export NUMEN_MODEL=~/.local/share/vosk-models/small-en-us
