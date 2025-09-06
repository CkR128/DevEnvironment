#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
dry="0"

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    fi
    shift
done

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
copy_dir_local .config/ nvim/ $HOME/.config
copy_dir_local .config/ yabai/ $HOME/.config
copy_dir_local .config/ skhd/ $HOME/.config
copy_dir_local .config/ tmux/ $HOME/.config
copy_dir .local/ $HOME/.local
execute chmod -R u+x $HOME/.local/scripts

copy_file  .config/kanatarc  $HOME/.config
copy_file  ./.zprofile  $HOME
copy_file  ./tmux/.tmux.conf  $HOME
copy_file  ./.ready-tmux $HOME
copy_file  ./.tmuxDaemonLoader $HOME
copy_file  ./.tmux-cht-languages $HOME
copy_file  ./.tmux-cht-command $HOME

execute chmod u+x $HOME/.ready-tmux
execute chmod u+x $HOME/.tmuxDaemonLoader

