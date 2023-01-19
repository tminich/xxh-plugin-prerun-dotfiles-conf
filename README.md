Modified version of the official `xxh-plugin-prerun-dotfiles`-plugin. Instead of relying on files stored in the repository it
expects the `home` directory and `pip-requirements.txt` file to be in `~/.xxh/.xxh/config/xxh-plugin-prerun-dotfiles-conf`.

The `home` directory contains the files which will be copied to xxh home directory (default `/home/user/.xxh/`) before running shell.
The [XDG](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) directory `.config`
will be copied to `$XDG_CONFIG_HOME` (default `/home/user/.xxh/.config`). Learn more about [home settings in docs](https://github.com/xxh/xxh/wiki#how-to-set-homeuser-as-home-on-host).

## Note!
The plugin copy files only once during first start. It copies the files from plugin home directory to the host xxh home directory
as addition and without replacing. It means if you hadn't the directory it will appear. If you have directory with files
but without the file from plugin home it just appears.

Be carefully if you are using [non-hermetic environment](https://github.com/xxh/xxh/wiki#how-to-set-homeuser-as-home-on-host) by using `+hhh '~' +hhx '~'` arguments.

## Install
From xxh repo:
```bash
xxh +I xxh-plugin-prerun-dotfiles-conf
# or from any Github repo: xxh +I https://github.com/<user>/xxh-plugin-prerun-dotfiles-conf
```
Connect:
```
xxh yourhost +if
```

## Preinstall PyPi packages
Add PyPi packages to `pip-requirements.txt` and they will be in `$XXH_HOME/.local`.
This is compatible with [xxh-shell-xonsh](https://github.com/xxh/xxh-shell-xonsh), [xxh-plugin-prerun-python](https://github.com/xxh/xxh-plugin-prerun-python) and `pip install --user`.
