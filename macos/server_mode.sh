#!/usr/bin/env bash
## Configure this Mac to act as an always-on server (lid closed, ethernet, power).
set -uo pipefail

FAILURES=()
fail() { echo "  [error] $*" >&2; FAILURES+=("$*"); }
run_step() { local label="$1"; shift; "$@" || fail "$label"; }
step() { echo; echo "==> $*"; }

step "SSH (Remote Login)"
run_step "Enable SSH" sudo systemsetup -setremotelogin on

step "Power Management"
run_step "Disable sleep" sudo pmset -a sleep 0 disablesleep 1
run_step "Wake on network" sudo pmset -a womp 1
run_step "Disable hibernation" sudo pmset -a hibernatemode 0

echo ""
if [[ ${#FAILURES[@]} -gt 0 ]]; then
    echo "Done with ${#FAILURES[@]} failure(s):"
    for f in "${FAILURES[@]}"; do echo "  - $f"; done
    exit 1
else
    echo "Done."
fi
