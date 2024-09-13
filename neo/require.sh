
# Get directory containing the this script.
neodir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo $neodir

# Source a neo module.
require() {
  name="$1"
  source "${neodir}/modules/${name}.sh"
}

