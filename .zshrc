# color codes
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
GRAY="\e[90m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m"
LIGHT_MAGENTA="\e[95m"
LIGHT_CYAN="\e[96m"
WHITE="\e[97m"

# formatting codes
END="\e[0m"
BOLD="\e[1m"
DIM="\e[2m"
ITALIC="\e[3m"
UNDERLINE="\e[4m"

# aliases
alias zsource="source ~/.zshrc"
alias zshrc="vim ~/.zshrc && zsource"

# git
git config --global pager.branch false
git config --global alias.a add
git config --global alias.ac 'commit --amend'
git config --global alias.b branch
git config --global alias.ba 'branch -a'
git config --global alias.c checkout
git config --global alias.cam 'commit --am'
git config --global alias.co 'commit -m'
git config --global alias.d 'branch -d'
git config --global alias.D 'branch -D'
git config --global alias.df diff
git config --global alias.f 'fetch origin --prune'
git config --global alias.fp 'push -f'
git config --global alias.l log
git config --global alias.ll 'log --oneline'
git config --global alias.p pull
git config --global alias.pu push
git config --global alias.s status
git config --global alias.sh show

# funcs
function refreshm {
  git branch | grep -E '(main|master)' | xargs -n 1 git checkout
  git fetch origin --prune
  git pull
}

function rmbranches {
  refreshm
  git branch --merged | grep -v '\*' | xargs -n 1 git branch -d
}

function mergem {
  refreshm
  git checkout -
  git merge master
}

function rebasem {
  refreshm
  git checkout -
  git rebase master
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

function help {
  echo -e "
  ${LIGHT_CYAN}effit${END}             ${DIM}amend commit, rebasem, and force push (--no-verify)${END}
  ${LIGHT_CYAN}kp [pid]${END}          ${DIM}kill process${END}
  ${LIGHT_CYAN}mergem${END}            ${DIM}merge main/master${END}
  ${LIGHT_CYAN}rebasem${END}           ${DIM}rebase main/master${END}
  ${LIGHT_CYAN}refreshm${END}          ${DIM}prune/pull main/master${END}
  ${LIGHT_CYAN}xcode-install${END}     ${DIM}install xcode dev tools${END}
  ${LIGHT_CYAN}xcode-reinstall${END}   ${DIM}reinstall xcode dev tools${END}
  ${LIGHT_CYAN}yolo${END}              ${DIM}amend commit and force push (--no-verify)${END}
  ${LIGHT_CYAN}zshrc${END}             ${DIM}edit & source ~/.zshrc${END}
  ${LIGHT_CYAN}zsource${END}           ${DIM}source ~/.zshrc${END}
"
}

# todo: pure prompt

