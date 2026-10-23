#!/bin/sh

get_git() {
    if [ -d "$2" ]; then
        git -C "$2" pull
    else
        git clone "$1" "$2"
    fi
}

get_http() {
    curl -L -o "$2" "$1"
}

cd ~/.config/lite-xl

mkdir -p libraries
mkdir -p plugins

# gitdiff_highlight
get_git https://github.com/vincens2005/lite-xl-gitdiff-highlight plugins/gitdiff_highlight

# lintplus
get_git https://github.com/liquidev/lintplus plugins/lintplus

# lsp
get_git https://github.com/lite-xl/lite-xl-lsp plugins/lsp
get_git https://github.com/lite-xl/lite-xl-widgets libraries/widget
get_http https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua plugins/snippets.lua
get_http https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua plugins/lsp_snippets.lua

# scm
get_git https://github.com/lite-xl/lite-xl-scm plugins/scm
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/language_diff.lua plugins/language_diff.lua

# ephemeral_tabs
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/ephemeral_tabs.lua plugins/ephemeral_tabs.lua

# eval
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/eval.lua plugins/eval.lua

# fontconfig
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/fontconfig.lua plugins/fontconfig.lua

# gitstatus
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/gitstatus.lua plugins/gitstatus.lua

# indentguide
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/indentguide.lua plugins/indentguide.lua

# minimap
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/minimap.lua plugins/minimap.lua

# nerdicons
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/nerdicons.lua plugins/nerdicons.lua
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/font_symbols_nerdfont_mono_regular.lua libraries/font_symbols_nerdfont_mono_regular.lua

# scalestatus
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/scalestatus.lua plugins/scalestatus.lua

# search_ui
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/search_ui.lua plugins/search_ui.lua

# select_colorscheme
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/select_colorscheme.lua plugins/select_colorscheme.lua

# selectionhighlight
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/selectionhighlight.lua plugins/selectionhighlight.lua

# sort
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/sort.lua plugins/sort.lua

# spellcheck
get_http https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/spellcheck.lua plugins/spellcheck.lua
