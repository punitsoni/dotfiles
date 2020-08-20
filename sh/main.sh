# Main entry point for shell config.

# Source the common shell config.
source $CFGS/sh/common.sh

# Source Shell specific config.
if [[ -n ${ZSH_VERSION} ]]; then
  source $CFGS/sh/zsh_config.zsh
elif [[ -n ${BASH_VERSION} ]]; then
  source $CFGS/sh/bash_config.sh
fi
