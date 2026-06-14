#!/usr/bin/env bash
# Sanity-checks the neovim config by loading it headlessly and verifying
# that key modules load without errors.
set -uo pipefail

NVIM_CONFIG="${DOTFILES:-$HOME/dotfiles}/nvim"
PASS=0
FAIL=0

check() {
    local desc="$1" lua="$2"
    local out
    out=$(nvim --headless -u "$NVIM_CONFIG/init.lua" \
        -c "lua $lua" \
        -c "qa!" 2>&1)
    if [[ -n "$out" ]]; then
        echo "  [FAIL] $desc"
        # shellcheck disable=SC2001
        echo "$out" | sed 's/^/         /'
        ((FAIL++))
    else
        echo "  [pass] $desc"
        ((PASS++))
    fi
}

echo "==> Neovim config sanity check"
echo "    config: $NVIM_CONFIG"
echo "    nvim:   $(nvim --version | head -1)"
echo ""

echo "==> Core modules"
check "general options"   "require('ps.general')"
check "lazy plugins load" "require('ps.golazy')"
check "lsp config"        "require('ps.lsp')"
check "keymaps"           "require('ps.keymaps')"
check "actions"           "require('ps.actions')"

echo ""
echo "==> Plugin availability"
check "nvim-cmp"         "require('cmp')"
check "telescope"        "require('telescope')"
check "snacks"           "require('snacks')"
check "nvim-treesitter"  "require('nvim-treesitter')"
check "lualine"          "require('lualine')"
check "gitsigns"         "require('gitsigns')"

echo ""
echo "==> LSP handlers"
check "handlers (no deprecated vim.lsp.with)" \
    "local h = require('ps.lsp.handlers'); assert(type(h.hover) == 'table')"
check "capabilities module" \
    "local c = require('ps.lsp.capabilities'); assert(type(c.get()) == 'table')"

echo ""
if [[ $FAIL -gt 0 ]]; then
    echo "Result: $PASS passed, $FAIL failed"
    exit 1
else
    echo "Result: all $PASS checks passed"
fi
