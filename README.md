# .dotfiles

My dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/)
and [Homebrew](https://brew.sh).

## Structure

Each top-level folder is a stow *package*, mirroring the path relative to
`$HOME`:

```
.dotfiles/
├── zsh/.zshrc                  -> ~/.zshrc
├── git/.gitconfig              -> ~/.gitconfig
├── tmux/.tmux.conf             -> ~/.tmux.conf
├── nvim/.config/nvim/          -> ~/.config/nvim
├── ai-memory/install.sh        installs/configures ai-memory
├── Brewfile                    Homebrew packages
└── install.sh                  full bootstrap
```

## Installation

```sh
git clone git@github.com:coelho013/.dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

`install.sh`:

1. installs Homebrew (if missing) and runs `brew bundle`;
2. creates the symlinks with `stow` — conflicting real files are moved to
   `~/.dotfiles-backup/<date>/`;
3. runs `ai-memory/install.sh`.

### Nerd Font

The zsh prompt uses a Nerd Font icon for the git branch. On macOS the
Brewfile installs JetBrains Mono Nerd Font. On WSL the font must be installed
on Windows (download from <https://www.nerdfonts.com/font-downloads>) and
selected in the Windows Terminal profile; otherwise set `GIT_SYMBOL=''` in
`.zshrc`.

## Day-to-day usage

```sh
# (re)link a package
stow -d ~/.dotfiles -t ~ -R nvim

# remove a package's links
stow -d ~/.dotfiles -t ~ -D tmux

# update the Brewfile with what is currently installed
brew bundle dump --file ~/.dotfiles/Brewfile --force --brews --taps

# update ai-memory to the latest release
~/.dotfiles/ai-memory/install.sh --update
```

To add a new app, create `<app>/` with the path relative to `$HOME`
(e.g. `alacritty/.config/alacritty/alacritty.toml`) and add it to `PACKAGES`
in `install.sh`.
