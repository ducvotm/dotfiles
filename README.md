## Hi 😂

Every day I am using vim, and I feel like I can learn new things every day.
So please don't wonder or judge why this repo has many commits.

### Main tools

- homebrew (pkgs manager)
- nvim (code editor)
- tmux (term multiplexer)
- ghostty and wezterm for terminal emulator
- aerospace is a window manager for macos (i3 like)
- zshell
- GNU stow is a symlink management tool

_Note_: Some tools I also recommend: lazydocker, bat, fzf, autocompletion, ... (can be installed with brew)

## Installing steps

- You need a package manager, if you are using macos, **homebrew** is a good one.

### Homebrew

[link](https://docs.brew.sh/Installation)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### After installing homebrew let's rock

```shell
brew install nvim
brew install tmux
brew install --cask ghostty
brew install --cask wezterm
brew install stow
brew install zsh
```

### Where should your settings be stored?

With stow you can create symlink from a directory to a target directory.
So ideally, all settings shoul be in a directory, for example `~/dotfiles`

```shell
cd
mkdir dotfiles
```

After that, create dir tree structure for each tool with same structure as in its docs.
For instance, with nvim, you should place your configs in `~/.config/nvim`

-> Create dir structure like this in dotfiles

```shell
cd ~/dotfiles
mkdir -p nvim/.config/nvim
```

Do the same steps with the other tools.
Then run this to create symlinks

```shell
stow nvim
stow zsh
stow aerospace
stow tmux
stow wezterm
stow ghostty
```

for more information about gnustow: [link](https://www.gnu.org/software/stow/)

## Note:

- You need Iterm/Wezeterm,...(not default macos terminal) because this terminal can not represent right theme
- Nerd font for view icon, text, folder, ... [link](https://www.nerdfonts.com/)
- Need to install delve for debugging: `brew install delve`
- Need ripgrep for telescope live grep

```shell
brew install ripgrep
```

- Need wget to help mason to download zip,... from internet

```shell
brew install wget
```

### Backup pkgs by brew

```shell
brew bundle dump --file=Brewfile --force
```

Re-install again

```shell
brew bundle --file=~/Brewfile
```

Linux

- skip un-supported packs

```shell
brew bundle check --file=Brewfile
sed -i '/cask /d' Brewfile
```

### Nvim setup

- I use lazy to manage plugins, you can use packer
- To sync or update plugins

```shell
:Lazy sync
:Lazy update
```

- I think it's better if we keep our settings at a simple level, don't set many things
  that you rarely use or you can achieve this purpose by some simple commands.

- Check log lsp:

```shell
nvim ~/.local/state/nvim/lsp.log
```

or

```
:LspLog
```

- Vim help is so helpful. Use it as much as you can
  example

```
:help Mason
```

## Integrate local LLM with nvim

I tried to run the LLM models in docker, allocated it 16GB ram, 4 cores CPU but it did not work effectively.
So I install ollama in my native macos machine.

[ollama](https://ollama.com/)

- Gave deepseek a try but it was so slow (model depends on GPU also, while Macbook M series are different )
- You can have web UI to do prompting, I run it with docker:
  [docker cp file](./docker-compose.yaml)

- My nvim - llm integration settings are in:
  [llm](./nvim/.config/nvim/lua/plugins/llm.lua)

  **Note that you should install llm-ls via Mason**
