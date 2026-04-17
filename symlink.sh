#!/usr/bin/env bash
# symlink.sh - stow-like symlinker that handles partial directories
# Usage: symlink.sh <package_dir> [target_dir]
# Example: symlink.sh ~/.dotfiles/cc-dotfiles/claude ~

set -euo pipefail

PACKAGE="${1:?Usage: symlink.sh <package_dir> [target_dir]}"
TARGET="${2:-$HOME}"
PACKAGE="$(cd "$PACKAGE" && pwd)"
TARGET="$(cd "$TARGET" && pwd)"

link_files() {
    local src_dir="$1"
    local dst_dir="$2"

    for src in "$src_dir"/.[!.]* "$src_dir"/*; do
        [[ -e "$src" || -L "$src" ]] || continue

        local name="${src##*/}"
        local dst="$dst_dir/$name"

        if [[ -d "$src" ]]; then
            if [[ ! -e "$dst" ]]; then
                ln -sv "$src" "$dst"
            elif [[ -L "$dst" ]]; then
                echo "already symlinked: $dst"
            else
                # real directory exists, recurse into it
                link_files "$src" "$dst"
            fi
        else
            if [[ -L "$dst" ]]; then
                echo "already symlinked: $dst"
            elif [[ -e "$dst" ]]; then
                echo "conflict, skipping: $dst (remove it first)"
            else
                ln -sv "$src" "$dst"
            fi
        fi
    done
}

link_files "$PACKAGE" "$TARGET"
