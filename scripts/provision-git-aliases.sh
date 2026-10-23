#!/usr/bin/env zsh
# One-time provisioning: sets global git aliases if not already set.
# Run manually after cloning dotfiles on a new machine: ./scripts/provision-git-aliases.sh

git config --global --get pager.branch >/dev/null 2>&1 || git config --global pager.branch false

typeset -A git_aliases=(
  a    add
  ac   'commit --amend'
  b    branch
  ba   'branch -a'
  c    checkout
  cam  'commit --am'
  co   'commit -m'
  d    'branch -d'
  D    'branch -D'
  df   diff
  f    'fetch origin --prune'
  fp   'push -f'
  l    log
  ll   'log --oneline'
  p    pull
  pu   push
  s    status
  sh   show
)
for k v in "${(@kv)git_aliases}"; do
  git config --global --get "alias.$k" >/dev/null 2>&1 || git config --global "alias.$k" "$v"
done
