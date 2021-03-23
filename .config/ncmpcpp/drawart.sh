padding_top=5
ueber_height=10
ueber_width=20
cover_path=/tmp/cover.jpg
FIFO=/tmp/ncmpcpp-ueberzug-fifo

main() {
    kill_previous_instance >/dev/null 2>&1
    display_cover_image    2>/dev/null
    detect_window_resizes  >/dev/null 2>&1
}

kill_previous_instances() {
    script_name=$(basename "$0")
    for pid in $(pidof -x "$script_name"); do
        if [ "$pid" != $$ ]; then
            kill -15 "$pid"
        fi 
    done
}

display_cover_image() {
    send_to_ueberzug \
        action "add" \
        identifier "mpd_cover" \
        path "$cover_path" \
        x "0" \
				y "$(expr $(tput lines) - 12)" \
        height "$ueber_height" \
        width "$ueber_width" \
        synchronously_draw "True" \
        scaler "forced_cover" \
        scaling_position_x "0.5"
}

detect_window_resizes() {
    {
        trap 'display_cover_image' WINCH
        while :; do sleep .1; done
    } &
}
send_to_ueberzug() {
    old_IFS="$IFS"

    # Ueberzug's "simple parser" uses tab-separated
    # keys and values so we separate words with tabs
    # and send the result to the wrapper's FIFO
    IFS="$(printf "\t")"
    echo "$*" > "$FIFO"

    IFS=${old_IFS}
}

main
