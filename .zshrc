# Path to your oh-my-zsh installation.
export ZSH=/Users/rui.ramos/.oh-my-zsh

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
plugins=(vi-mode history-substring-search git z macos tmux sudo docker docker-compose kubectl)

# User configuration
#export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin":$PATH

# export MANPATH="/usr/local/man:$MANPATH"

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
alias vi="nvim"
alias vim="nvim"
alias k="kubectl"
alias wk="watch kubectl"
alias vlogin='vault login -method=github token="$GITHUB_TOKEN"'

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M vicmd 'v' visual-mode

bindkey '^X^E' edit-command-line

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

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

#source ~/.zprofile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.zprofile
