# Path to your oh-my-zsh installation.
export ZSH=/Users/ruiramos/.oh-my-zsh

export NODE_PATH="/usr/local/lib/node_modules"
export GOPATH=$HOME/projects/go
export EDITOR=vi
export MOUNT_PATH="/server/apps/ometria.console2"

export AWS_ASSUME_ROLE_TTL=1h
export AWS_SESSION_TTL=12h

# Ometria stuff
export OMETRIA_PATH="/Users/ruiramos/ometria/apps/"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh

export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/test-cluster

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
source '/Users/ruiramos/projects/google-cloud-sdk/completion.zsh.inc'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-syntax-highlighting history-substring-search git z osx tmux sudo docker docker-compose kubectl kubetail zsh-aws-vault)

# User configuration
export PATH="/Users/ruiramos/ometria/apps/ometria.deployment/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/lib/postgresql94/bin:/usr/local/go/bin:$GOPATH/bin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/ruiramos/projects/google-cloud-sdk/path.zsh.inc'

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias vi="vim"
alias k="kubectl"
alias wk="watch kubectl"


#Docker
# eval "$(docker-machine env default)"

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M vicmd 'v' visual-mode

bindkey '^X^E' edit-command-line

opensprint(){
  vi ~/.scratch/sprint.md;
}
opentodo(){
  vi ~/.scratch/todo.md;
}
zle -N opensprint
zle -N opentodo

bindkey '^X^S' opensprint
bindkey '^X^T' opentodo

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

tossh() {
  ssh ec2-user@`php ~/ometria/apps/ometria.deployment/bin/ec2-ip $1`
}

om-account-id() {
  om-psql prod0 -d ometria_core -U ometria_readonly -p psql10 -- -c "select id, title, hash, url, db_shard from accounts where id='$1'";
}

dcul() {
  docker-compose up -d "$1" && docker-compose logs --tail 50 -f "$1"
}

dc() {
  if [ -z $1 ]; then
    echo "Usage: dc <container> <operation> [<arguments>]";
    echo "Ex: dc reporting logs --tail 50"
    return
  fi
  car=$1
  shift
  cdr=$@
  docker ps -a | grep "$car" | awk '{ print $1; }' | xargs -I{} -n 1 sh -c "docker $cdr {}"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# kube grafana tunnel
function kgraf () {
  kubectl port-forward --namespace grafana2 $(kubectl get pod --namespace=grafana2 -l app=grafana | grep Running | tail -n 1 | awk '{print $1}') 3000 &
  sleep 1
  open "http://localhost:3000"
  fg
}

function kpf(){
  kubectl port-forward $(kubectl get pod -l app=$1 --no-headers -o custom-columns=":metadata.name") 8888:$2
}

function kpfncat(){
  ncat -l -p 8889 -c "nc 127.0.0.1 8888" --keep-open
}

function gopen(){
  open $(git remote get-url origin |  sed -n 's/.*github.com:\(.*\).git/https:\/\/github.com\/\1/p')
}

function kaw(){
  echo need cluster upgrade
  #kubectl apply $@ -o name | xargs kubectl wait --for condition=available
}

### function to move into proj directory
apps() {
    cd $(find /server/apps -maxdepth 1 -type d | fzf)
}

if [ /Users/ruiramos/projects/google-cloud-sdk/bin/kubectl ]; then source <(kubectl completion zsh); fi

# vulkan stuff, for nannou
export VULKAN_SDK="$HOME/.vulkansdk/macOS"
export PATH=$VULKAN_SDK/bin:$PATH
export DYLD_LIBRARY_PATH=$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d/MoltenVK_icd.json
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d
export SHADERC_LIB_DIR="$VULKAN_SDK/lib"

prompt_aws_vault() {
  local vault_segment
  vault_segment="`prompt_aws_vault_segment`"
  [[ $vault_segment != '' ]] && prompt_aws_vault_segment cyan black "$vault_segment"
}

source ~/.zprofile
