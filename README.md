# .dotfiles

Meus dotfiles, gerenciados com [GNU Stow](https://www.gnu.org/software/stow/)
e [Homebrew](https://brew.sh).

## Estrutura

Cada pasta de primeiro nível é um *pacote* do stow, espelhando o caminho a
partir de `$HOME`:

```
.dotfiles/
├── zsh/.zshrc                  -> ~/.zshrc
├── git/.gitconfig              -> ~/.gitconfig
├── tmux/.tmux.conf             -> ~/.tmux.conf
├── nvim/.config/nvim/          -> ~/.config/nvim
├── ai-memory/install.sh        instala/configura o ai-memory
├── Brewfile                    pacotes do Homebrew
└── install.sh                  bootstrap completo
```

## Instalação

```sh
git clone git@github.com:coelho013/.dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

O `install.sh`:

1. instala o Homebrew (se faltar) e roda `brew bundle`;
2. cria os symlinks com `stow` — arquivos reais que conflitem vão para
   `~/.dotfiles-backup/<data>/`;
3. roda `ai-memory/install.sh`.

## Uso no dia a dia

```sh
# (re)linkar um pacote
stow -d ~/.dotfiles -t ~ -R nvim

# remover os links de um pacote
stow -d ~/.dotfiles -t ~ -D tmux

# atualizar o Brewfile com o que está instalado
brew bundle dump --file ~/.dotfiles/Brewfile --force --brews --taps

# atualizar o ai-memory para a última release
~/.dotfiles/ai-memory/install.sh --update
```

Para adicionar um novo app, crie `<app>/` com o caminho relativo a `$HOME`
(ex: `alacritty/.config/alacritty/alacritty.toml`) e inclua-o em `PACKAGES`
no `install.sh`.
