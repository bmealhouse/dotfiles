# starship
eval "$(starship init bash)"

# ansible
export PATH="$HOME/Library/Python/$(python3 -V | perl -pe '($_)=/(\d\.\d*)/')/bin:$PATH"

# git completion
source ~/.bash/.git-completion.bash

# pipx
export PATH="$PATH:/Users/$USER/.local/bin"

# tfswitch
export PATH="$PATH:/Users/$USER/bin"

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# aliases
# alias aws="aws --profile default"
alias bashrc="vim ~/.bashrc && bsource"
alias bsource="source ~/.bash_profile && source ~/.bashrc"
alias code='code 2> /dev/null || /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -la'
alias macicons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources'
alias nodet='nlx tsx --tsconfig tsconfig.base.json'
alias phpserve='php -S localhost:9000'
alias ta='terraform apply'
alias td='terraform destroy'
alias tfu='terraform force-unlock'
alias ti='terraform init'
alias tp='terraform plan'
alias tr='rm .terraform.lock.hcl && rm -rf ./.terraform'
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

function decode {
  node -e "console.log(decodeURIComponent('$1'))"
}

function dt {
  node -e "console.log(new Date($1))"
}

function 1099ff {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/add-force-filed-flag.ts "$@"
  cd $CURRENT_DIR
}

function 1099ffg {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/federal-file-generation.ts "$@"
  cd $CURRENT_DIR
}

function 1099ila {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/il-acknowledgement.ts "$@"
  cd $CURRENT_DIR
}

function 1099ilt {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/il-transmission.ts "$@"
  cd $CURRENT_DIR
}

function 1099lpm {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/lob-paper-mailing.ts "$@"
  cd $CURRENT_DIR
}

function 1099mdt {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/md-transmission.ts "$@"
  cd $CURRENT_DIR
}

function 1099sfg {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/state-file-generation.ts "$@"
  cd $CURRENT_DIR
}

function 1099update {
  CURRENT_DIR=$PWD
  cd ~/dev/abound/tools/scripts
  npx tsx src/v4-1099-filing/update-status.ts "$@"
  cd $CURRENT_DIR
}

function awsenv {
  bcli get-configured-aws-creds -P "$@" &>/dev/null # not sure why this command is currently throwing an error
  export AWS_DEFAULT_REGION=us-west-2
  export AWS_PROFILE="$@"
}

function ri {
  CURRENT_DIR=$PWD
  cd ~/dev/infra /rocketship-cli
  git checkout main
  git fetch origin --prune
  git pull
  go build -C src/cmd -o ../../rcli && sudo mv rcli /usr/local/bin/
  cd $CURRENT_DIR
}
