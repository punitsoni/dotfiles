# Neo

Neo is a top level command runner that provides a single entry point
for executing common system configuration tasks.

```
neo [options] <command> [command_args]
```

## Commands

A function named with the pattern `cmd::<name>` becomes the entry point for a
subcommand `name`. Commands are discovered automatically (via `declare -F`), so
adding a command is just defining a function in a module:

```bash
cmd::hello() {
  echo "hello ${1:-world}"
}
```

Then `neo hello there` runs it.

## Modules

Commands live in modules under `neo/modules/*.sh`, all sourced by default at
startup. Shared helpers are in `neo/lib/util.sh`:

- `perr <msg>` — echo to stderr
- `logv <msg>` — echo to stderr only when `--verbose` is set
- `die <msg>` — print an error and exit 1

## Options

| Option | Description |
|--------|-------------|
| `-h`, `--help` | Show usage and list all available commands |
| `-s`, `--showcmd <command>` | Print the definition of a command (via `declare -f`) |
| `--no-default` | Disable loading the default modules |
| `-v`, `--verbose` | Enable verbose output |
| `-m`, `--module <module>` | Load an additional module |

### Introspection

- `neo --help` lists every available command.
- `neo -s <command>` (or `--showcmd`) prints the source of `cmd::<command>`,
  which is handy for inspecting what a task actually does before running it:

  ```
  $ neo -s frg
  cmd::frg () {
      ...
  }
  ```
