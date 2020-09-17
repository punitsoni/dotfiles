import yaml
# import argparse

import sys

from pathlib import Path

def run():
    with open('config.yml', 'r') as f:
        includes = [x + '.yml'
                    for x in yaml.load(f, Loader=yaml.FullLoader)['include']]

    final_config = {}
    for cfg in includes:
        with open(cfg, 'r') as f:
            d = yaml.load(f, Loader=yaml.FullLoader)
            final_config.update(d)

    config_file_path = Path.home()/'.config'/'alacritty'/'alacritty.yml'

    with open(config_file_path, 'w') as f:
        s = yaml.dump(final_config, sort_keys=False)
        print('Final Config:')
        print(s)
        print(f'Writing to {config_file_path}')
        f.write(s)

def main():
    # TODO: Argument parsing.
    # parser = argparse.ArgumentParser('Alacrity config')
    # subparsers = parser.add_subparsers()

    # cmd_build = subparsers.add_parser('build')
    # args = parser.parse_args()

    run()

if __name__ == '__main__':
    main()
