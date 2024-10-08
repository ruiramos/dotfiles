# Path to your oh-my-zsh installation.
export ZSH=/Users/ruiramos/.oh-my-zsh

export NVM_LAZY_LOAD=true
export NODE_PATH="/usr/local/lib/node_modules"
export EDITOR=vi
export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# Alias for intel x86_64 brew
alias axbrew='arch -x86_64 /usr/local/homebrew/bin/brew'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# The next line enables shell command completion for gcloud.
#source '/Users/ruiramos/projects/google-cloud-sdk/completion.zsh.inc'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode git z macos tmux sudo docker docker-compose kubectl asdf zsh-nvm)

# User configuration
#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin":$PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.wasme/bin:$HOME/.cargo/bin"

# export MANPATH="/usr/local/man:$MANPATH"

source ~/.zprofile
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="nvim"
alias vim="nvim"
alias k="kubectl"
alias wk="watch kubectl"
alias vlogin='vault login -method=github token="$GITHUB_TOKEN"'

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M vicmd 'v' visual-mode

bindkey '^X^E' edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function gopen(){
  open $(git remote get-url origin |  sed -n 's/.*github.com:\(.*\).git/https:\/\/github.com\/\1/p')
}

# vulkan stuff, for nannou
#export VULKAN_SDK="$HOME/.vulkansdk/macOS"
#export PATH=$VULKAN_SDK/bin:$PATH
#export DYLD_LIBRARY_PATH=$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
#export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d/MoltenVK_icd.json
#export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d
#export SHADERC_LIB_DIR="$VULKAN_SDK/lib"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Wasmer
export WASMER_DIR="/Users/ruiramos/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export PATH="/usr/local/opt/libpq/bin:$PATH"

#export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
#eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Created by `pipx` on 2023-02-28 22:28:34
export PATH="$PATH:/Users/ruiramos/.local/bin"

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ruiramos/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ruiramos/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ruiramos/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ruiramos/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
