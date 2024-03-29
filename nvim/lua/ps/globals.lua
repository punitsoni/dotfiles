---------------------------------------------------------------
-- This files adds functions / variables to global namespace.
---------------------------------------------------------------
-- Reload a module without restarting nvim.
R = function(name)
  require'plenary.reload'.reload_module(name)
  return require(name)
end

