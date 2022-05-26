
prepend_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}


_GUIX_PROFILE=~/.config/guix/current
export GUIX_PROFILE=~/.guix-profile
export GUIX_LOCPATH=$GUIX_PROFILE/lib/locale

export INFOPATH=$_GUIX_PROFILE/share/info:$INFOPATH
export XDG_DATA_DIRS=$GUIX_PROFILE/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}

prepend_path $_GUIX_PROFILE/bin
[ -f $GUIX_PROFILE/etc/profile ] && . $GUIX_PROFILE/etc/profile


# export ATOM_NODE_URL=http://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist
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
export QT_QPA_PLATFORMTHEME=qt5ct
export VISUAL=nvim


prepend_path ~/opt/janet/bin
prepend_path ~/opt/python310/bin
prepend_path ~/bin
export PATH
