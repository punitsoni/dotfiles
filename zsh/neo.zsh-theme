
local username="%{$fg[yellow]%}%n%{$reset_color%}"
local hostname="%{$fg[yellow]%}%m%{$reset_color%}"
local sym="λ"
local newline=$'\n'
local dirname="%{$fg[blue]%}%c%{$reset_color%}"
local prompt_symbol="%(?:%{$fg_bold[green]%}${sym}:%{$fg_bold[red]%}${sym})"

PROMPT='${username}@${hostname}${newline}${dirname} ${prompt_symbol} '
