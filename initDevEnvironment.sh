#!/usr/bin/env bash

script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
filter=""
dry="1"

cd $script_dir
scripts=$(find setupScripts -maxdepth 1 -mindepth 1 -perm +111 -type f)

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

log "run: filter=$filter"

for script in $scripts; do
    if echo "$script" | grep -qv "$filter"; then
        log "Filtering: $filter -- $script"
        continue
    fi
    log "Running script: $script"
    execute ./$script
done

source ~/.zprofile

echo ""
echo ""

echo "=========================================="
echo "Run 'source ~/.zprofile' to re-source node."
echo "=========================================="

echo ""
echo ""
