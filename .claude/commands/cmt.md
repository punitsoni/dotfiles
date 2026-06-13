Commit all staged and unstaged changes in the working tree.

1. Run `git status` and `git diff` to understand what changed.
2. Run `git log -5` to match the repo's commit message style.
3. Stage all modified/deleted tracked files (do not use `git add -A` — add specific files by name to avoid accidentally including untracked files like .env).
4. Write a concise commit message focused on *why*, not *what*. One short subject line; add a body only if the change genuinely needs explanation.
5. Do NOT include any "Co-Authored-By" or "Generated with" trailer lines in the commit message.
6. Commit and run `git status` to confirm success.
