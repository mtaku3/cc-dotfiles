# cc-dotfiles

Personal Claude Code dotfiles and plugin marketplace.

## Layout

- `claude/` — files symlinked into `~` (e.g. `~/.claude/`)
- `plugins/` — Claude Code plugins published via the marketplace
- `.claude-plugin/marketplace.json` — marketplace manifest (`mtaku3-plugins`)
- `symlink.sh` — stow-like symlinker that handles partial directories
- `LICENSE` — MIT

## Usage

Symlink dotfiles into `$HOME`:

```sh
./symlink.sh ./claude ~
```

Add the marketplace in Claude Code:

```
/plugin marketplace add mtaku3/cc-dotfiles
```

## License

MIT
