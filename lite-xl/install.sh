#!/bin/sh

cd ~/.config/lite-xl

mkdir -p libraries
mkdir -p plugins

# gitdiff_highlight
[ ! -d plugins/gitdiff_highlight ] && \
  git clone https://github.com/vincens2005/lite-xl-gitdiff-highlight plugins/gitdiff_highlight || \
  git -C plugins/gitdiff_highlight pull

# lintplus
[ ! -d plugins/lintplus ] && \
  git clone https://github.com/liquidev/lintplus plugins/lintplus || \
  git -C plugins/lintplus pull

# lsp
[ ! -d plugins/lsp ] && \
  git clone https://github.com/lite-xl/lite-xl-lsp plugins/lsp || \
  git -C plugins/lsp pull
[ ! -d libraries/widget ] && \
  git clone https://github.com/lite-xl/lite-xl-widgets libraries/widget || \
  git -C libraries/widget pull
[ ! -d plugins/lintplus ] && \
  git clone https://github.com/liquidev/lintplus plugins/lintplus || \
  git -C plugins/lintplus pull
curl -L -o plugins/snippets.lua https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/snippets.lua
curl -L -o plugins/lsp_snippets.lua https://raw.githubusercontent.com/vqns/lite-xl-snippets/main/lsp_snippets.lua

# scm
[ ! -d plugins/scm ] && \
  git clone https://github.com/lite-xl/lite-xl-scm plugins/scm || \
  git -C plugins/scm pull
curl -L -o plugins/language_diff.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/language_diff.lua

# ephemeral_tabs
curl -L -o plugins/ephemeral_tabs.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/ephemeral_tabs.lua

# eval
curl -L -o plugins/eval.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/eval.lua

# fontconfig
curl -L -o plugins/fontconfig.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/fontconfig.lua

# gitstatus
curl -L -o plugins/indentguide.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/gitstatus.lua

# indentguide
curl -L -o plugins/indentguide.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/indentguide.lua

# minimap
curl -L -o plugins/minimap.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/minimap.lua

# nerdicons
curl -L -o plugins/nerdicons.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/nerdicons.lua
curl -L -o libraries/font_symbols_nerdfont_mono_regular.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/font_symbols_nerdfont_mono_regular.lua

# scalestatus
curl -L -o plugins/scalestatus.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/scalestatus.lua

# search_ui
curl -L -o plugins/search_ui.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/search_ui.lua

# select_colorscheme
curl -L -o plugins/select_colorscheme https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/select_colorscheme.lua

# selectionhighlight
curl -L -o plugins/selectionhighlight.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/selectionhighlight.lua

# sort
curl -L -o plugins/sort.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/sort.lua

# spellcheck
curl -L -o plugins/spellcheck.lua https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/master/plugins/spellcheck.lua
