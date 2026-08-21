-- Compatibility shim for the *legacy* (`master`-branch) nvim-treesitter running
-- on Neovim 0.11+.
--
-- Neovim 0.11 changed the query-match API: the table passed to predicate and
-- directive handlers now maps a capture id to a *list* of TSNodes
-- (`match[id] = { node, ... }`) instead of a single node (`match[id] = node`).
-- The frozen `master` branch of nvim-treesitter predates that change, so its
-- handlers (nth?, is?, kind-eq?, set-lang-from-mimetype!,
-- set-lang-from-info-string!, downcase!) do `get_node_text(match[id])` on a
-- Lua list and crash with "attempt to call method 'range' (a nil value)" —
-- notably on any buffer with injected languages (markdown code fences, HTML
-- <script>, ...), which nvim-treesitter-context re-parses on scroll.
--
-- This wraps query.add_directive/add_predicate *only* while re-registering
-- nvim-treesitter's own handlers, normalizing each match value from the new
-- list form to the last node (mirroring the `main` branch's behavior). Core
-- Neovim and other plugins keep registering against the real, list-aware API.
--
-- Remove this file (and its require in treesitter.lua) if nvim-treesitter is
-- ever migrated to the `main` branch, which handles the new API natively.

local M = {}

--- Convert a 0.11+ match ({id -> {node, ...}}) to the legacy shape ({id -> node}).
--- Leaves anything that isn't a list-of-nodes untouched.
---@param match table
---@return table
local function normalize(match)
  local out = {}
  for k, v in pairs(match) do
    if type(v) == "table" and type(v[#v]) == "userdata" then
      out[k] = v[#v]
    else
      out[k] = v
    end
  end
  return out
end

local function wrap(handler)
  return function(match, ...)
    return handler(normalize(match), ...)
  end
end

function M.setup()
  local query = require("vim.treesitter.query")

  local real_add_directive = query.add_directive
  local real_add_predicate = query.add_predicate

  query.add_directive = function(name, handler, opts)
    return real_add_directive(name, wrap(handler), opts)
  end
  query.add_predicate = function(name, handler, opts)
    return real_add_predicate(name, wrap(handler), opts)
  end

  -- Force nvim-treesitter's handlers to (re-)register through our wrappers.
  -- They register with force=true, so re-requiring safely replaces them.
  package.loaded["nvim-treesitter.query_predicates"] = nil
  require("nvim-treesitter.query_predicates")

  -- Restore the real functions for everyone else (core directives like set!,
  -- offset!, gsub! expect the list form and must not be normalized).
  query.add_directive = real_add_directive
  query.add_predicate = real_add_predicate
end

return M
