if status --is-login
    set -x PATH ~/python/bin ~/programs ~/programs/chicken/bin ~/.cabal/bin $PATH
    set -x CHICKEN_REPOSITORY ~/programs/chicken_repository
    set -x ATOM_NODE_URL http://gh-contractor-zcbenz.s3.amazonaws.com/atom-shell/dist
    set -x QT_QPA_PLATFORMTHEME qt5ct
    set -x VISUAL nvim
end
