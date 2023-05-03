
prepend_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}


# export CHICKEN_REPOSITORY=~/programs/chicken_repository
# export GDK_BACKEND=wayland
# export QT_AUTO_SCREEN_SCALE_FACTOR=1
# export QT_ENABLE_HIGHDPI_SCALING=1
# export QT_QPA_PLATFORM=wayland
# export QT_WAYLAND_FORCE_DPI=120
# export SDL_VIDEODRIVER=wayland
# export SWEETHOME3D_JAVA3D=1.6
# export WLR_DRM_NO_MODIFIERS=1
export EDITOR=nvim
# export LIBGL_ALWAYS_SOFTWARE=1
export QT_QPA_PLATFORMTHEME=qt5ct
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export VISUAL=nvim

prepend_path ~/opt/python310/bin
prepend_path ~/opt/river/bin
prepend_path ~/bin
export PATH


# nix_profile_sh=~/.nix-profile/etc/profile.d/nix.sh
# [ -e $nix_profile_sh ] && . $nix_profile_sh
# export LOCALE_ARCHIVE=~/.nix-profile/lib/locale/locale-archive

