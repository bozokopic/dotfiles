: ${HOME:?}

primary=eDP-1

primary_width=1920
primary_height=1080
primary_res=${primary_width}x${primary_height}

bg1=$HOME/.pictures/bg1.jpg
bg2=$HOME/.pictures/bg2.jpg


display_names() {
    wlr-randr --json | \
        jq -r "map(select($1)) | .[] | .name" 2>/dev/null
}

display_widths() {
    wlr-randr --json | \
        jq -r "map(select($1)) | .[] | .modes | map(select(.current)) | .[] | .width" 2>/dev/null
}

display_heights() {
    wlr-randr --json | \
        jq -r "map(select($1)) | .[] | .modes | map(select(.current)) | .[] | .height" 2>/dev/null
}
