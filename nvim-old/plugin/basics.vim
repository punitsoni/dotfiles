
function! g:CommandToBuffer(cmd) abort
  redir @a
  silent execute a:cmd
  redir end
  enew
  put a
  normal! gg
endfunction

" Write output of a given command into new buffer.
command! -nargs=1 C2b call g:CommandToBuffer(<q-args>)

