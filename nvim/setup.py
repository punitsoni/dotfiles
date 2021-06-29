# python 3.6+ required to run this script.

import sys
from pathlib import Path

config_path = Path.home() / '.config' / 'nvim'
dotfiles_config_path = Path.home() / 'dotfiles' / 'nvim'

if config_path.is_symlink():
    config_path.unlink(missing_ok=True)
else:
    sys.exit(f'Error: {config_path} already exists.')

config_path.symlink_to(dotfiles_config_path, target_is_directory=True)

print(f'{config_path} linked to {dotfiles_config_path}')
