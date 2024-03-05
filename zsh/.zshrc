# starship
eval "$(starship init zsh)"

# ansible
export PATH="$HOME/Library/Python/$(python3 -V | perl -pe '($_)=/(\d\.\d*)/')/bin:/opt/homebrew/bin:$PATH"

# git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath+=~/.zsh
autoload -Uz compinit && compinit

# java
export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
export GRADLE_USER_HOME="$HOME/.gradle"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---

# aliases
alias aws="aws --profile default"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -la'
alias macicons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources'
alias nodet='nlx tsx --tsconfig tsconfig.base.json'
alias phpserve='php -S localhost:9000'
alias ts='node -e "console.log(Date.now())"'
alias uuid='node -e "console.log(require(\"crypto\").randomUUID())"'
alias vim='nvim'
alias zshrc="vim ~/.zshrc && zsource"
alias zsource="source ~/.zshrc && source ~/.zprofile"

# # exiftool renames
# exiftool -d '%Y-%m-%d %H.%M.%S' -ext jpg '-FileName<${FileModifyDate} ${ImageSize}%-c.${FileTypeExtension}' '-FileName<${CreateDate} ${ImageSize}%-c.${FileTypeExtension}' '-FileName<${DateTimeOriginal} ${ImageSize}%-c.${FileTypeExtension}' .
# exiftool -d '%Y-%m-%d %H.%M.%S' -ext mov '-FileName<${FileModifyDate} ${ImageSize} ${Duration}.${FileTypeExtension}' '-FileName<${CreateDate} ${ImageSize} ${Duration}.${FileTypeExtension}' '-FileName<${DateTimeOriginal} ${ImageSize} ${Duration}.${FileTypeExtension}' .
# exiftool -r -d '%Y-%m-%d  %H.%M.%S' -ext jpg -ext png -ext bmp '-FileName<${FileModifyDate}  ${ImageSize}  ${FileSize}%-c.${FileTypeExtension}' '-FileName<${CreateDate}  ${ImageSize}  ${FileSize}%-c.${FileTypeExtension}' '-FileName<${DateTimeOriginal}  ${ImageSize}  ${FileSize}%-c.${FileTypeExtension}' .
# exiftool -r -d '%Y-%m-%d  %H.%M.%S' -ext avi -ext mov -ext mp4 -ext 3gp '-FileName<${FileModifyDate}  ${ImageSize}  ${Duration}  ${FileSize}%-c.${FileTypeExtension}' '-FileName<${CreateDate}  ${ImageSize}  ${Duration}  ${FileSize}%-c.${FileTypeExtension}' '-FileName<${DateTimeOriginal}  ${ImageSize}  ${Duration}  ${FileSize}%-c.${FileTypeExtension}' .

# git
if ! git config --global --get pager.branch >/dev/null 2>&1; then
  git config --global pager.branch false
fi

if ! git config --global --get alias.a >/dev/null 2>&1; then
  git config --global alias.a add
fi

if ! git config --global --get alias.ac >/dev/null 2>&1; then
  git config --global alias.ac 'commit --amend'
fi

if ! git config --global --get alias.b >/dev/null 2>&1; then
  git config --global alias.b branch
fi

if ! git config --global --get alias.ba >/dev/null 2>&1; then
  git config --global alias.ba 'branch -a'
fi

if ! git config --global --get alias.c >/dev/null 2>&1; then
  git config --global alias.c checkout
fi

if ! git config --global --get alias.cam >/dev/null 2>&1; then
  git config --global alias.cam 'commit --am'
fi

if ! git config --global --get alias.co >/dev/null 2>&1; then
  git config --global alias.co 'commit -m'
fi

if ! git config --global --get alias.d >/dev/null 2>&1; then
  git config --global alias.d 'branch -d'
fi

if ! git config --global --get alias.D >/dev/null 2>&1; then
  git config --global alias.D 'branch -D'
fi

if ! git config --global --get alias.df >/dev/null 2>&1; then
  git config --global alias.df diff
fi

if ! git config --global --get alias.f >/dev/null 2>&1; then
  git config --global alias.f 'fetch origin --prune'
fi

if ! git config --global --get alias.fp >/dev/null 2>&1; then
  git config --global alias.fp 'push -f'
fi

if ! git config --global --get alias.l >/dev/null 2>&1; then
  git config --global alias.l log
fi

if ! git config --global --get alias.ll >/dev/null 2>&1; then
  git config --global alias.ll 'log --oneline'
fi

if ! git config --global --get alias.p >/dev/null 2>&1; then
  git config --global alias.p pull
fi

if ! git config --global --get alias.pu >/dev/null 2>&1; then
  git config --global alias.pu push
fi

if ! git config --global --get alias.s >/dev/null 2>&1; then
  git config --global alias.s status
fi

if ! git config --global --get alias.sh >/dev/null 2>&1; then
  git config --global alias.sh show
fi

# funcs
function rmbranches {
  git fetch origin --prune
  git pull
  git branch -vv | grep ': gone]' | awk '{ print $1 }' | xargs -n 1 git branch -D
}

function yolo {
  git add .
  git commit --amend --no-verify
  git push --force --no-verify
}

function effit {
  git add .
  git commit --amend --no-verify
  rebasem
  git push --force --no-verify
}

function kp {
  echo "killing pid: $(lsof -ti:$1)"
  lsof -ti:$1 | xargs kill
}

function xcode-install {
  xcode-select --install
}

function xcode-reinstall {
  sudo rm -rf $(xcode-select -print-path)
  xcode-install
}

function dt {
  node -e "console.log(new Date($1))"
}

function 1099ffg {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/federal-file-generation.ts "$@"
  cd $CURRENT_DIR
}

function 1099ila {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/il-acknowledgement.ts "$@"
  cd $CURRENT_DIR
}

function 1099ilt {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/il-transmission.ts "$@"
  cd $CURRENT_DIR
}

function 1099lpm {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/lob-paper-mailing.ts "$@"
  cd $CURRENT_DIR
}

function 1099mdt {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/md-transmission.ts "$@"
  cd $CURRENT_DIR
}

function 1099sfg {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/state-file-generation.ts "$@"
  cd $CURRENT_DIR
}

function 1099update {
  CURRENT_DIR=$PWD
  cd ~/dev/abound2/tools/scripts
  npx tsx src/v4-1099-filing/update-status.ts "$@"
  cd $CURRENT_DIR
}


# Created by `pipx` on 2024-02-26 21:01:27
export PATH="$PATH:/Users/brent/.local/bin"
