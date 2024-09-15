# Get directory containing the this script. Assumes that `require.sh` lives in
# neo root directory.
# neodir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source a neo module.
require() {
  name="$1"
  source "${NEODIR}/modules/${name}.sh"
}

