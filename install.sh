#!/usr/bin/env zsh
# Stow all packages into $HOME, then run one-time provisioning steps.
set -euo pipefail

cd "$(dirname "$0")"

stow .
./scripts/provision-git-aliases.sh
