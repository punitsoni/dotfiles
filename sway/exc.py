#!/usr/bin/env python3

import os
from argparse import ArgumentParser

cli = ArgumentParser()
subparsers = cli.add_subparsers(dest="subcommand")

def subcommand(args=[], parent=subparsers):
    def decorator(func):
        parser = parent.add_parser(func.__name__, description=func.__doc__)
        for arg in args:
            parser.add_argument(*arg[0], **arg[1])
        parser.set_defaults(func=func)
    return decorator


@subcommand()
def terminal(args):
    cmd = ['kitty']
    os.execvp(cmd[0], cmd)


@subcommand()
def screenlock(args):
    cmd = ['swaylock', '-c', '000000']
    os.execvp(cmd[0], cmd)


def main():
    args = cli.parse_args()
    if args.subcommand is None:
        cli.print_help()
        return
    args.func(args)


if __name__ == '__main__':
    main()
  
