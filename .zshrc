# path
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/Library/Python/$(python3 -V | perl -pe '($_)=/(\d\.\d*)/')/bin:$PATH" # ansible
export PATH="$PATH:/Users/$USER/.local/bin" # pipx
export PATH="$PATH:/Users/$USER/bin" # tfswitch

# other exports
export LIBRARY_PATH="/opt/homebrew/lib"
export CPATH="/opt/homebrew/include"
export HISTSIZE=1000000
export SAVEHIST=1000000

# rust
. "$HOME/.cargo/env"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath+=~/.zsh
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# open bugger line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# magic space
bindkey ' ' magic-space

# enable advanced move command in zsh
autoload zmv

# clear screen, keep buffer
clear-keep-buffer() {
  zle clear-screen
}
zle -N clear-keep-buffer
bindkey '^Xl' clear-keep-buffer

# keybindings
bindkey -s '^Xgc' 'git commit -m ""\C-b'

# aliases
alias aws-auth='bcli get-configured-aws-creds --instance techops'
alias bashrc="vim ~/.bashrc && bsource"
alias bsource="source ~/.bash_profile && source ~/.bashrc"
alias cat='bat'
alias code='code 2> /dev/null || /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias corepack_enable='corepack enable --install-directory ~/.volta/bin'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -la'
alias macicons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources'
alias nodet='nlx tsx --tsconfig packages/typescript-config/base.json'
alias phpserve='php -S localhost:9000'
alias ts='node -e "console.log(Date.now())"'
alias uuid='node -e "console.log(require(\"crypto\").randomUUID())"'
alias vim='nvim'
alias weather='curl wttr.in/hill%20city,%20mn'
alias zshrc="$EDITOR ~/.zshrc && zsource"
alias zsource="source ~/.zshrc && source ~/.zprofile"

# suffix aliases
alias -s md="bat"
alias -s mov="open"
alias -s png="open"
alias -s mp4="open"
alias -s go="$EDITOR"
alias -s js="$EDITOR"
alias -s ts="$EDITOR"
alias -s yaml="bat -l yaml"
alias -s yml="bat -l yaml"
alias -s json="bat"

# global aliases
alias -g JQ='| jq'
alias -g C='| pbcopy'

#
# ------- functions -------
#

# run a command in a different directory without leaving the shell's cwd changed
function run-in-subshell {
  local dir=$1
  shift
  (cd "$dir" && "$@")
}

function decode {
  node -e "console.log(decodeURIComponent('$1'))"
}

# datetime
function dt {
  node -e "console.log(new Date($1))"
}

function fix-ssh {
  ssh-add -l
  ssh-add ~/.ssh/gitlab_bill_ed25519
  ssh -T git@git.hq.bill.com
}

function force-delete-secret {
  aws secretsmanager delete-secret --secret-id "$@" --force-delete-without-recovery --region us-west-2
}

# kill process
function kp {
  echo "killing pid: $(lsof -ti:$1)"
  lsof -ti:$1 | xargs kill
}

function reflect-update {
  run-in-subshell ~/dev/reflect-open bash -c '
    git fetch upstream
    git checkout master
    git merge upstream/master
    pnpm install
    pnpm tauri build
  ' _ "$@"
}

function rmbranches {
  git fetch origin --prune
  git pull
  git branch -vv | grep ': gone]' | awk '{ print $1 }' | xargs -n 1 git branch -D
}

# remove node_modules
function rnm {
  echo "\n🗑️  removing node_modules recursively…"
  rm -rf ./**/node_modules

  echo "\n🗑️  removing lock file(s)…"
  rm package-lock.json yarn.lock

  echo "\n📦 installing dependencies…"
  ni

  # taxservice monorepo has a nested filing-dashboard package with its own lockfile
  if [[ "$PWD" == *taxservice* ]]; then
    echo "\n📦 detected taxservice monorepo, installing filing-dashboard dependencies…"
    (
      cd filing-dashboard
      rm package-lock.json
      npm install
    )

    echo "\n🍰 detected taxservice monorepo, updating lambda layers…"
    nr layers:update
  fi
}

function xcode-install {
  xcode-select --install
}

function xcode-reinstall {
  sudo rm -rf $(xcode-select -print-path)
  xcode-install
}

#
# ------- ets reports -------
#

function billing-direct {
  run-in-subshell ~/dev/taxservice-scripts bash -c '
    git pull
    npm run script -- src/reports/billing-direct-state-1099-filing-event-report.ts "$@"
  ' _ "$@"
}

function billing-federal {
  run-in-subshell ~/dev/taxservice-scripts bash -c '
    git pull
    npm run script -- src/reports/billing-federal-1099-filing-event-report.ts "$@"
  ' _ "$@"
}

function billing-mailing {
  run-in-subshell ~/dev/taxservice-scripts bash -c '
    git pull
    npm run script -- src/reports/billing-document-mailing-event-report.ts "$@"
  ' _ "$@"
}

function dashboard {
  run-in-subshell ~/dev/taxservice-scripts bash -c '
    git pull
    npm run script -- src/reports/ets-dashboard.ts "$@"
  ' _ "$@"
}

function stats {
  run-in-subshell ~/dev/taxservice-scripts bash -c '
    git pull
    npm run script -- src/reports/ets-stats.ts "$@"
  ' _ "$@"
}

#
# ------- rocketship -------
#

function ri {
  run-in-subshell ~/dev/infra/rocketship-cli bash -c '
    git checkout main
    git fetch origin --prune
    git pull
    go build -C src/cmd -o ../../rcli && sudo mv rcli /usr/local/bin/
  '
}

function rib {
  run-in-subshell ~/dev/infra/rocketship-cli bash -c '
    go build -C src/cmd -o ../../rcli && sudo mv rcli /usr/local/bin/
  '
}

function rip {
  run-in-subshell ~/dev/infra/rocketship-cli bash -c '
    GOOS=linux GOARCH=amd64 go build -C src/cmd -o ../../rcli && mv rcli "../../$1"
  ' _ "$@"
}

# ------- do not edit -------

# bcli: PATH
export PATH="/Users/brent.mealhouse/.local/bin:$PATH"
fpath=(/Users/brent.mealhouse/.zsh/completions $fpath)
# bcli homebrew shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=/Users/brent.mealhouse/.rd/bin:$PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/brent.mealhouse/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Load Angular CLI autocompletion.
source <(ng completion script)

### BCLI:codeartifact-token:START (DO NOT EDIT)
# --- AWS CodeArtifact Token Refresh ---
refresh_codeartifact_token() {
  TOKEN_FILE="$HOME/.codeartifact_token"
  echo "Setting up CodeArtifact token..."

  if ! command -v bcli >/dev/null 2>&1; then
    echo "Error: bcli not found" >&2
    return 1
  fi

  if ! bcli get-configured-aws-creds -I techops -P techops -C; then
    echo "Error: Failed to get AWS credentials" >&2
    return 1
  fi

  if [ ! -s "$TOKEN_FILE" ]; then
    echo "Error: Token file missing or empty" >&2
    return 1
  fi

  read -r CODEARTIFACT_AUTH_TOKEN < "$TOKEN_FILE"
  export CODEARTIFACT_AUTH_TOKEN
  echo "✓ CodeArtifact token exported"
}

# Wrapper function to refresh token before 'yarn' or 'yarn install' only
yarn() {
  # Only refresh token for 'yarn' with no args or 'yarn install' (unless SKIP_CODEARTIFACT_TOKEN_REFRESH is set to a truthy value)
  if ! printf '%s\n' "${SKIP_CODEARTIFACT_TOKEN_REFRESH:-}" | grep -iq '^\(true\|1\|yes\)$' && ([ "$#" -eq 0 ] || [ "$1" = "install" ]); then
    refresh_codeartifact_token && command yarn "$@"
  else
    command yarn "$@"
  fi
}
### BCLI:codeartifact-token:END (DO NOT EDIT)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
