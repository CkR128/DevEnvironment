#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
filter=""
dry="1"

while [[ $# > 0 ]]; do
    if [[ "$1" == "--execute" ]]; then
        dry="0"
    else
        filter="$1"
    fi
    shift
done

if [[ $dry == "1" ]]; then
    echo ""
    echo "---------------------------------"
    echo " DRY RUN"
    echo ""
    echo " Use --execute to confirm script"
    echo "---------------------------------"
    echo ""
fi


log() {
    if [[ $dry == "1" ]]; then
        echo "[DRY_RUN]: $@"
    else
        echo "$@"
    fi
}

execute() {
    log "Execute: $@"
    if [[ $dry == "1" ]]; then
        return
    fi
    "$@"
}

if [ ! -d "$HOME/.config" ]; then
    execute mkdir -p "$HOME/.config"
fi

copy_dir_path() {
    pushd $1
    to=$2
    execute rm -rf $to/* 
    execute cp -r . $to/
    popd
}

copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

copy_dir_local() {
    pushd $1
    localdir=$2
    to=$3
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    execute rm -rf $to/$localdir
    execute cp -r $localdir $to/$localdir
    popd
}

copy_file() {
    from=$1
    to=$2
    name=$(basename $from)
    execute rm $to/$name
    execute cp $from $to/$name
}

cd $script_dir
directories=("nvim" "yabai" "skhd" "tmux")
for index in "${!directories[@]}"; do
    dir="${directories[$index]}"
    if echo "$dir" | grep -qv "$filter"; then
        log "Filtering: $filter -- $dir"
        continue
    fi
    log "Copying: $dir"
    copy_dir_local .config/ "$dir"/ $HOME/.config
done

if echo "local" | grep -qv "$filter"; then
    log "Filtering: $filter -- local"
else
    log "Copying: local"
    copy_dir .local/ $HOME/.local
    execute chmod -R u+x $HOME/.local/scripts
fi

files=(
".config/kanatarc,$HOME/.config"
".config/.zprofile,$HOME"
".config/.zshrc,$HOME"
)

for index in "${!files[@]}"; do
    file="${files[$index]}"
    IFS=',' read -r -a elements <<< "${file}"
    len=${#elements[@]}
    if [ "$len" -lt 2 ]; then
        echo "Array didn't have the correct length, skipping"
        continue
    fi

    origin=${elements[0]}
    dest=${elements[1]}
    if echo "$origin" | grep -qv "$filter"; then
        log "Filtering: $filter -- $origin"
        continue
    fi
    log "Copying: $origin"
    copy_file "$origin" "$dest"
done

if echo "tmux" | grep -qv "$filter"; then
    log "Filtering: $filter -- tmux"
else
    echo "Copying Tmux"
    copy_file  ./tmux/.tmux.conf  $HOME
    copy_file  ./.ready-tmux $HOME
    execute chmod u+x $HOME/.ready-tmux
    copy_file  ./.tmuxDaemonLoader $HOME
    execute chmod u+x $HOME/.tmuxDaemonLoader
    copy_file  ./.tmux-cht-languages $HOME
    copy_file  ./.tmux-cht-command $HOME
fi

if echo "screen" | grep -qv "$filter"; then
    log "Filtering: $filter -- screen"
else
    echo "Copying screen"
    copy_file  ./.config/.screenrc  $HOME
fi

if echo "sketchybar" | grep -qv "$filter"; then
    log "Filtering: $filter -- Sketchybar"
else
    echo "Copying screen"
    copy_dir_path ./.config/sketchybar $HOME/.config/sketchybar
    execute chmod -R u+x $HOME/.config/sketchybar/
fi
